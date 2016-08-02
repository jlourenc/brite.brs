'////////////////////
'/// Brite Logger ///
'////////////////////
'
' @author Jérémy Lourenço <https://github.com/jlourenc>
'
function BriteLogger () as Object

    if not m.doesExist("BriteLogger")

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


            setLevel: function (level as Integer) as Void
                if (level >= m.LEVEL.OFF AND level <= m.LEVEL.ALL)
                    m._level = level
                else
                    m.warning("BriteLogger", BriteErrors().BRITE_DEBUG.UNKNOWN_DEBUG_LEVEL)
                end if
            end function


            error: function (tag as String, message as String) as Void
                if (m._level >= m.LEVEL.ERROR) then m._log(tag, message, m._DECORATION.ERROR)
            end function


            warning: function (tag as String, message as String) as Void
                if (m._level >= m.LEVEL.WARNING) then m._log(tag, message, m._DECORATION.WARNING)
            end function


            info: function (tag as String, message as String) as Void
                if (m._level >= m.LEVEL.INFO) then m._log(tag, message, m._DECORATION.INFO)
            end function


            debug: function (tag as String, message as String) as Void
                if (m._level >= m.LEVEL.ALL) then m._log(tag, message, m._DECORATION.DEBUG)
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
                m._timespan.mark()

                return m
            end function


            _log: function (component as String, message as String, decoration as Object) as Void
                print m._getTimestamp() + " " + decoration.COLOUR.replace("%s", "[" + component + "]") + " " + message + " " decoration.COLOUR.replace("%s", decoration.DESCRIPTION) + " " + m._getTimespan()
            end function


            _getTimestamp: function () as String
                m._dateTime.mark()
                isoDateTime = m._dateTime.ToISOString()
                timestamp = isoDateTime.left(isoDateTime.len()-1) + "." + m._formatMilliseconds(m._dateTime.getMilliseconds())

                return m._DECORATION.TIME.COLOUR.replace("%s", "[" + timestamp + "]")
            end function


            _getTimespan: function () as String
                timespan = m._timespan.totalSeconds().toStr() + "." + m._formatMilliseconds(m._timespan.totalMilliseconds()/60)
                m._timespan.mark()

                return m._DECORATION.TIME.COLOUR.replace("%s", "[+" + timespan+ "]")
            end function


            _formatMilliseconds: function (milliseconds as Integer) as String
                return Right("00" + milliseconds.toStr(), 3)
            end function

        }._init()

    end if

    return m.BriteLogger

end function
