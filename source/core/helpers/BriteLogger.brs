'////////////////////
'/// Brite Logger ///
'////////////////////
'
' @author Jérémy Lourenço <https://github.com/jlourenc>

' Implementation of a logger singleton.
' This logger logs a timestamp for each log and a time span between the current log
' and the previous log. e.g. '[2016-08-03T15:41:50.145] [Tag] This is an error message [ERROR] [+0.123]'
' It also implements coloration/decoration to identify log levels, using ANSI escape colour codes.
'
' @usage
'    BriteLogger().error("Tag", "Simple Message")
'    BriteLogger().warning("Tag", "Message with {0} param", 1)
'    BriteLogger().info("Tag", "Message with {0} params: {1} & {2}", ["multiple", Invalid, aFunction])
'    BriteLogger().debug("Tag", "Message with {0} embedded params: {1} & {2}", ["multiple", {fooId:1,list:[{}]}, [{}, true]])
'
' Levels:
'    0 = OFF
'    1 = Error
'    2 = Error & warning
'    3 = Error & warning & info
'    4 = Error & warning & info & debug
'

'
' @return {BriteLogger} singleton - the BriteLogger singleton
'
'
function BriteLogger () as Object

    if IsInvalid(m.BriteLogger)

        m.BriteLogger = {

            '//////////////////
            '/// PUBLIC API ///
            '//////////////////

            LEVEL: {
                OFF: 0
                ERROR: 1
                WARNING: 2
                INFO: 3
                ALL: 4
            }

            ' Sets logs level
            '
            ' @param {Integer} level - a log level
            '
            setLevel: function (level as Integer) as Void
                if (level >= m.LEVEL.OFF AND level <= m.LEVEL.ALL)
                    m._level = level
                else
                    m.warning("BriteLogger", BriteErrors().BRITE_LOGGER.UNKNOWN_DEBUG_LEVEL)
                end if
            end function


            ' Logs an error level message
            '
            ' @param {String} tag - a tag name, define a component this log relates to
            ' @param {String} message - a log message
            ' @param {Object} args - an argument or an array of arguments, message markers are replaced by their associated argument
            '
            error: function (tag as String, message as String, args = [] as Object) as Void
                if (m._level >= m.LEVEL.ERROR)
                    m._log(m._formatLog(tag, m._formatMessage(message, args), m._DECORATION.ERROR))
                end if
            end function


            ' Logs a warning level message
            '
            ' @param {String} tag - a tag name, define a component this log relates to
            ' @param {String} message - a log message
            ' @param {Object} args - an argument or an array of arguments, message markers are replaced by their associated argument
            '
            warning: function (tag as String, message as String, args = [] as Object) as Void
                if (m._level >= m.LEVEL.WARNING)
                    m._log(m._formatLog(tag, m._formatMessage(message, args), m._DECORATION.WARNING))
                end if
            end function


            ' Logs an info level message
            '
            ' @param {String} tag - a tag name, define a component this log relates to
            ' @param {String} message - a log message
            ' @param {Object} args - an argument or an array of arguments, message markers are replaced by their associated argument
            '
            info: function (tag as String, message as String, args = [] as Object) as Void
                if (m._level >= m.LEVEL.INFO)
                    m._log(m._formatLog(tag, m._formatMessage(message, args), m._DECORATION.INFO))
                end if
            end function


            ' Logs a debug level message
            '
            ' @param {String} tag - a tag name, define a component this log relates to
            ' @param {String} message - a log message
            ' @param {Object} args - an argument or an array of arguments, message markers are replaced by their associated argument
            '
            debug: function (tag as String, message as String, args = [] as Object) as Void
                if (m._level >= m.LEVEL.ALL)
                    m._log(m._formatLog(tag, m._formatMessage(message, args), m._DECORATION.DEBUG))
                end if
            end function


            ' Singleton destructor
            '
            dispose: function () as Void
                m._dateTime = Invalid
                m._timespan = Invalid

                GetGlobalAA().BriteLogger = Invalid
            end function


            '///////////////////////
            '/// PRIVATE MEMBERS ///
            '///////////////////////

            _DECORATION: {
                ERROR: {
                    COLOUR: chr(27) + "[31;1m%s" + chr(27) + "[0m"
                    DESCRIPTION: "[ERROR]"
                }
                WARNING: {
                    COLOUR: chr(27) + "[33;1m%s" + chr(27) + "[0m"
                    DESCRIPTION: "[WARNING]"
                }
                INFO: {
                    COLOUR: chr(27) + "[34;22m%s" + chr(27) + "[0m"
                    DESCRIPTION: "[INFO]"
                }
                DEBUG: {
                    COLOUR: chr(27) + "[90m%s" + chr(27) + "[0m"
                    DESCRIPTION: "[DEBUG]"
                }
                TIME: {
                    COLOUR: chr(27) + "[36;22m%s" + chr(27) + "[0m"
                }
            }

            _level: Invalid
            _dateTime: Invalid
            _timespan: Invalid


            '///////////////////////
            '/// PRIVATE METHODS ///
            '///////////////////////

            _init: function () as Object
                m._level = m.LEVEL.OFF
                m._dateTime = CreateObject("roDateTime")
                m._timespan = CreateObject("roTimespan")

                return m
            end function


            _log: function (log as String) as Void
                m._print(m._getTimestamp() + " " + log + " " + m._getTimespan())
            end function


            _getTimestamp: function () as String
                m._dateTime.mark()
                isoDateTime = m._dateTime.ToISOString()
                timestamp = isoDateTime.left(isoDateTime.len()-1) + "." + m._formatMilliseconds(m._dateTime.getMilliseconds())

                return m._DECORATION.TIME.COLOUR.replace("%s", "[" + timestamp + "]")
            end function


            _getTimespan: function () as String
                timespan = m._timespan.totalSeconds().toStr() + "." + m._formatMilliseconds(m._timespan.totalMilliseconds())
                m._timespan.mark()

                return m._DECORATION.TIME.COLOUR.replace("%s", "[+" + timespan+ "]")
            end function


            _formatLog: function (tag as String, message as String, decoration as Object) as String
                return decoration.COLOUR.replace("%s", "[" + tag + "]") + " " + message + " " + decoration.COLOUR.replace("%s", decoration.DESCRIPTION)
            end function


            _formatMessage: function (message as String, args as Object) as String
                if not IsArray(args)
                    args = [args]
                end if

                for i=0 to args.count()-1
                    message = message.replace("{" + i.toStr() + "}", m._formatArgument(args[i]))
                end for

                return message
            end function


            _formatArgument: function (arg as Object) as String
                if IsAssociativeArray(arg)
                    formattedArgument = "{"
                    if arg.count() > 0
                        for each argId in arg
                            formattedArgument = formattedArgument + argId.toStr() + ":" + m._formatArgument(arg[argId]) + ","
                        end for
                        formattedArgument = Left(formattedArgument, formattedArgument.len()-1)
                    end if
                    formattedArgument = formattedArgument + "}"
                else if IsArray(arg)
                    formattedArgument = "["
                    if arg.count() > 0
                        for each argItem in arg
                            formattedArgument = formattedArgument + m._formatArgument(argItem) + ","
                        end for
                        formattedArgument = Left(formattedArgument, formattedArgument.len()-1)
                    end if
                    formattedArgument = formattedArgument + "]"
                else
                    formattedArgument = arg.toStr()
                end if

                return formattedArgument
            end function


            _formatMilliseconds: function (milliseconds as Integer) as String
                return Right("00" + milliseconds.toStr(), 3)
            end function


            _print: function (log as String) as Void
                print log
            end function

        }._init()

    end if

    return m.BriteLogger

end function
