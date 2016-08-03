'unit-test: core/helpers/BriteLogger'

'/////////////
'/// SETUP ///
'/////////////

function setup_testBriteLogger () as Object
    return {
        SUT: CreateTestableBriteLogger()
        regex: {
            timestamp: "^" + chr(27) + "\[36\;22m\[[0-9]{4}\-[0-9]{2}\-[0-9]{2}T[0-9]{2}\:[0-9]{2}\:[0-9]{2}\.[0-9]{3}\]" + chr(27) + "\[0m "
            timespan: " " + chr(27) + "\[36\;22m\[\+[0-9]+.[0-9]{3}\]" + chr(27) + "\[0m$"
            error: chr(27) + "\[31\;1m\[{0}\]" + chr(27) + "\[0m {1} " + chr(27) + "\[31\;1m\[ERROR\]" + chr(27) + "\[0m"
            warning: chr(27) + "\[33\;1m\[{0}\]" + chr(27) + "\[0m {1} " + chr(27) + "\[33\;1m\[WARNING\]" + chr(27) + "\[0m"
            info: chr(27) + "\[34\;22m\[{0}\]" + chr(27) + "\[0m {1} " + chr(27) + "\[34\;22m\[INFO\]" + chr(27) + "\[0m"
            debug: chr(27) + "\[90m\[{0}\]" + chr(27) + "\[0m {1} " + chr(27) + "\[90m\[DEBUG\]" + chr(27) + "\[0m"
        }
    }
end function


function teardown_testBriteLogger () as Void
    BriteLogger().dispose()
    FakePrint().dispose()
end function


function CreateTestableBriteLogger () as Object
    testableBriteLogger = BriteLogger()

    testableBriteLogger._print = function (log as String) as Void
        FakePrint().setPrint(log)
    end function

    return testableBriteLogger
end function


'/////////////
'/// TESTS ///
'/////////////

'Constants'

sub testBriteLogger_Constants (t as Object)
    test = setup_testBriteLogger()

    t.assertEqual(0, test.SUT.LEVEL.OFF)
    t.assertEqual(1, test.SUT.LEVEL.ERROR)
    t.assertEqual(2, test.SUT.LEVEL.WARNING)
    t.assertEqual(3, test.SUT.LEVEL.INFO)
    t.assertEqual(4, test.SUT.LEVEL.ALL)

    teardown_testBriteLogger()
end sub


'Dispose'

sub testBriteLogger_Dispose (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'

    'WHEN'
    test.SUT.dispose()

    'THEN'
    t.assertInvalid(m.BriteLogger)

    teardown_testBriteLogger()
end sub


'Error'

sub testBriteLogger_ErrorDisabledByDefault (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    fooTag = "fooTag"
    fooMessage = "fooMessage"

    'WHEN'
    test.SUT.error(fooTag, fooMessage)

    'THEN'
    t.assertEqual("", FakePrint().getPrint())

    teardown_testBriteLogger()
end sub

sub testBriteLogger_ErrorDisabledLevelOff (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    fooTag = "fooTag"
    fooMessage = "fooMessage"
    test.SUT.setLevel(test.SUT.LEVEL.OFF)

    'WHEN'
    test.SUT.error(fooTag, fooMessage)

    'THEN'
    t.assertEqual("", FakePrint().getPrint())

    teardown_testBriteLogger()
end sub

sub testBriteLogger_ErrorEnabledLevelError (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    fooTag = "fooTag"
    fooMessage = "fooMessage{0}"
    fooArgs = "fooArg"
    test.SUT.setLevel(test.SUT.LEVEL.ERROR)

    'WHEN'
    test.SUT.error(fooTag, fooMessage, fooArgs)

    'THEN'
    regex = CreateObject("roRegex", test.regex.timestamp + test.regex.error.replace("{0}", fooTag).replace("{1}", "fooMessagefooArg") + test.regex.timespan, "i")
    t.assertTrue(regex.isMatch(FakePrint().getPrint()))

    teardown_testBriteLogger()
end sub

sub testBriteLogger_ErrorEnabledLevelWarning (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    fooTag = "fooTag"
    fooMessage = "fooMessage{0}"
    fooArgs = 1
    test.SUT.setLevel(test.SUT.LEVEL.WARNING)

    'WHEN'
    test.SUT.error(fooTag, fooMessage, fooArgs)

    'THEN'
    regex = CreateObject("roRegex", test.regex.timestamp + test.regex.error.replace("{0}", fooTag).replace("{1}", "fooMessage1") + test.regex.timespan, "i")
    t.assertTrue(regex.isMatch(FakePrint().getPrint()))

    teardown_testBriteLogger()
end sub

sub testBriteLogger_ErrorEnabledLevelInfo (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    fooTag = "fooTag"
    fooMessage = "fooMessage{0}"
    fooArgs = function () as Void
    end function
    test.SUT.setLevel(test.SUT.LEVEL.INFO)

    'WHEN'
    test.SUT.error(fooTag, fooMessage, fooArgs)

    'THEN'
    regex = CreateObject("roRegex", test.regex.timestamp + test.regex.error.replace("{0}", fooTag).replace("{1}", "fooMessageFunction") + test.regex.timespan, "i")
    t.assertTrue(regex.isMatch(FakePrint().getPrint()))

    teardown_testBriteLogger()
end sub

sub testBriteLogger_ErrorEnabledLevelDebug (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    fooTag = "fooTag"
    fooMessage = "fooMessage"
    fooArgs = true
    test.SUT.setLevel(test.SUT.LEVEL.ALL)

    'WHEN'
    test.SUT.error(fooTag, fooMessage, fooArgs)

    'THEN'
    regex = CreateObject("roRegex", test.regex.timestamp + test.regex.error.replace("{0}", fooTag).replace("{1}", "fooMessage") + test.regex.timespan, "i")
    t.assertTrue(regex.isMatch(FakePrint().getPrint()))

    teardown_testBriteLogger()
end sub


'Warning'

sub testBriteLogger_WarningDisabledByDefault (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    fooTag = "fooTag"
    fooMessage = "fooMessage"

    'WHEN'
    test.SUT.warning(fooTag, fooMessage)

    'THEN'
    t.assertEqual("", FakePrint().getPrint())

    teardown_testBriteLogger()
end sub

sub testBriteLogger_WarningDisabledLevelOff (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    fooTag = "fooTag"
    fooMessage = "fooMessage"
    test.SUT.setLevel(test.SUT.LEVEL.OFF)

    'WHEN'
    test.SUT.warning(fooTag, fooMessage)

    'THEN'
    t.assertEqual("", FakePrint().getPrint())

    teardown_testBriteLogger()
end sub

sub testBriteLogger_WarningDisabledLevelError (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    fooTag = "fooTag"
    fooMessage = "fooMessage"
    test.SUT.setLevel(test.SUT.LEVEL.ERROR)

    'WHEN'
    test.SUT.warning(fooTag, fooMessage)

    'THEN'
    t.assertEqual("", FakePrint().getPrint())

    teardown_testBriteLogger()
end sub

sub testBriteLogger_WarningEnabledLevelWarning (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    fooTag = "fooTag"
    fooMessage = "fooMessage{0}"
    fooArgs = [Invalid]
    test.SUT.setLevel(test.SUT.LEVEL.WARNING)

    'WHEN'
    test.SUT.warning(fooTag, fooMessage, fooArgs)

    'THEN'
    regex = CreateObject("roRegex", test.regex.timestamp + test.regex.warning.replace("{0}", fooTag).replace("{1}", "fooMessageInvalid") + test.regex.timespan, "i")
    t.assertTrue(regex.isMatch(FakePrint().getPrint()))

    teardown_testBriteLogger()
end sub

sub testBriteLogger_WarningEnabledLevelInfo (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    fooTag = "fooTag"
    fooMessage = "fooMessage{0}"
    fooArgs = [[{foo:{foo0:["foo0"]}},{foo1: Invalid}]]
    test.SUT.setLevel(test.SUT.LEVEL.INFO)

    'WHEN'
    test.SUT.warning(fooTag, fooMessage, fooArgs)

    'THEN'
    regex = CreateObject("roRegex", test.regex.timestamp + test.regex.warning.replace("{0}", fooTag).replace("{1}", "fooMessage\[\{foo:\{foo0:\[foo0\]\}\},\{foo1:invalid\}\]") + test.regex.timespan, "i")
    t.assertTrue(regex.isMatch(FakePrint().getPrint()))

    teardown_testBriteLogger()
end sub

sub testBriteLogger_WarningEnabledLevelAll (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    fooFunction = function () as Void
    end function
    fooTag = "fooTag"
    fooMessage = "{0}fooMessage{1}{2}"
    fooArgs = ["2", 3, fooFunction]
    test.SUT.setLevel(test.SUT.LEVEL.ALL)

    'WHEN'
    test.SUT.warning(fooTag, fooMessage, fooArgs)

    'THEN'
    regex = CreateObject("roRegex", test.regex.timestamp + test.regex.warning.replace("{0}", fooTag).replace("{1}", "2fooMessage3Function") + test.regex.timespan, "i")
    t.assertTrue(regex.isMatch(FakePrint().getPrint()))

    teardown_testBriteLogger()
end sub


'Info'

sub testBriteLogger_InfoDisabledByDefault (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    fooTag = "fooTag"
    fooMessage = "fooMessage"

    'WHEN'
    test.SUT.info(fooTag, fooMessage)

    'THEN'
    t.assertEqual("", FakePrint().getPrint())

    teardown_testBriteLogger()
end sub

sub testBriteLogger_InfoDisabledLevelOff (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    fooTag = "fooTag"
    fooMessage = "fooMessage"
    test.SUT.setLevel(test.SUT.LEVEL.OFF)

    'WHEN'
    test.SUT.info(fooTag, fooMessage)

    'THEN'
    t.assertEqual("", FakePrint().getPrint())

    teardown_testBriteLogger()
end sub

sub testBriteLogger_InfoDisabledLevelError (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    fooTag = "fooTag"
    fooMessage = "fooMessage"
    test.SUT.setLevel(test.SUT.LEVEL.ERROR)

    'WHEN'
    test.SUT.info(fooTag, fooMessage)

    'THEN'
    t.assertEqual("", FakePrint().getPrint())

    teardown_testBriteLogger()
end sub

sub testBriteLogger_InfoDisabledLevelWarning (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    fooTag = "fooTag"
    fooMessage = "fooMessage"
    test.SUT.setLevel(test.SUT.LEVEL.WARNING)

    'WHEN'
    test.SUT.info(fooTag, fooMessage)

    'THEN'
    t.assertEqual("", FakePrint().getPrint())

    teardown_testBriteLogger()
end sub

sub testBriteLogger_InfoEnabledLevelInfo (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    fooTag = "fooTag"
    fooMessage = "fooMessage{0}"
    fooArgs = [1, "2"]
    test.SUT.setLevel(test.SUT.LEVEL.INFO)

    'WHEN'
    test.SUT.info(fooTag, fooMessage, fooArgs)

    'THEN'
    regex = CreateObject("roRegex", test.regex.timestamp + test.regex.info.replace("{0}", fooTag).replace("{1}", "fooMessage1") + test.regex.timespan, "i")
    t.assertTrue(regex.isMatch(FakePrint().getPrint()))

    teardown_testBriteLogger()
end sub

sub testBriteLogger_InfoEnabledLevelAll (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    fooTag = "fooTag"
    fooMessage = "fooMessage{0}"
    fooArgs = []
    test.SUT.setLevel(test.SUT.LEVEL.ALL)

    'WHEN'
    test.SUT.info(fooTag, fooMessage, fooArgs)

    'THEN'
    regex = CreateObject("roRegex", test.regex.timestamp + test.regex.info.replace("{0}", fooTag).replace("{1}", "fooMessage\{0\}") + test.regex.timespan, "i")
    t.assertTrue(regex.isMatch(FakePrint().getPrint()))

    teardown_testBriteLogger()
end sub


'Debug'

sub testBriteLogger_DebugDisabledByDefault (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    fooTag = "fooTag"
    fooMessage = "fooMessage"

    'WHEN'
    test.SUT.debug(fooTag, fooMessage)

    'THEN'
    t.assertEqual("", FakePrint().getPrint())

    teardown_testBriteLogger()
end sub

sub testBriteLogger_DebugDisabledLevelOff (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    fooTag = "fooTag"
    fooMessage = "fooMessage"
    test.SUT.setLevel(test.SUT.LEVEL.OFF)

    'WHEN'
    test.SUT.debug(fooTag, fooMessage)

    'THEN'
    t.assertEqual("", FakePrint().getPrint())

    teardown_testBriteLogger()
end sub

sub testBriteLogger_DebugDisabledLevelError (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    fooTag = "fooTag"
    fooMessage = "fooMessage"
    test.SUT.setLevel(test.SUT.LEVEL.ERROR)

    'WHEN'
    test.SUT.debug(fooTag, fooMessage)

    'THEN'
    t.assertEqual("", FakePrint().getPrint())

    teardown_testBriteLogger()
end sub

sub testBriteLogger_DebugDisabledLevelWarning (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    fooTag = "fooTag"
    fooMessage = "fooMessage"
    test.SUT.setLevel(test.SUT.LEVEL.WARNING)

    'WHEN'
    test.SUT.debug(fooTag, fooMessage)

    'THEN'
    t.assertEqual("", FakePrint().getPrint())

    teardown_testBriteLogger()
end sub

sub testBriteLogger_DebugDisabledLevelInfo (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    fooTag = "fooTag"
    fooMessage = "fooMessage"
    test.SUT.setLevel(test.SUT.LEVEL.INFO)

    'WHEN'
    test.SUT.debug(fooTag, fooMessage)

    'THEN'
    t.assertEqual("", FakePrint().getPrint())

    teardown_testBriteLogger()
end sub

sub testBriteLogger_DebugEnabledLevelAll (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    fooTag = "fooTag"
    fooMessage = "fooMessage{0}{1}"
    fooArgs = ["fooArg0", [{fooArg1: true}]]
    test.SUT.setLevel(test.SUT.LEVEL.ALL)

    'WHEN'
    test.SUT.debug(fooTag, fooMessage, fooArgs)

    'THEN'
    regex = CreateObject("roRegex", test.regex.timestamp + test.regex.debug.replace("{0}", fooTag).replace("{1}", "fooMessagefooArg0\[\{fooArg1:true\}\]") + test.regex.timespan, "i")
    t.assertTrue(regex.isMatch(FakePrint().getPrint()))

    teardown_testBriteLogger()
end sub


'setLevel out of bounds'

sub testBriteLogger_setLevelBelowOffPrintsWarningIfWarningEnabled (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    briteLoggerTag = "BriteLogger"
    test.SUT.setLevel(test.SUT.LEVEL.WARNING)

    'WHEN'
    test.SUT.setLevel(test.SUT.LEVEL.OFF - 1)

    'THEN'
    regex = CreateObject("roRegex", test.regex.timestamp + test.regex.warning.replace("{0}", briteLoggerTag).replace("{1}", ".*") + test.regex.timespan, "i")
    t.assertTrue(regex.isMatch(FakePrint().getPrint()))

    teardown_testBriteLogger()
end sub

sub testBriteLogger_setLevelAboveAllIfWarningEnabled (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    briteLoggerTag = "BriteLogger"
    test.SUT.setLevel(test.SUT.LEVEL.WARNING)

    'WHEN'
    test.SUT.setLevel(test.SUT.LEVEL.ALL + 1)

    'THEN'
    regex = CreateObject("roRegex", test.regex.timestamp + test.regex.warning.replace("{0}", briteLoggerTag).replace("{1}", ".*") + test.regex.timespan, "i")
    t.assertTrue(regex.isMatch(FakePrint().getPrint()))

    teardown_testBriteLogger()
end sub

sub testBriteLogger_setLevelBelowOffDoesNotPrintWarningIfWarningDisabled (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    test.SUT.setLevel(test.SUT.LEVEL.OFF)

    'WHEN'
    test.SUT.setLevel(test.SUT.LEVEL.OFF - 1)

    'THEN'
    t.assertEqual("", FakePrint().getPrint())

    teardown_testBriteLogger()
end sub

sub testBriteLogger_setLevelAboveAllDoesNotPrintWarningIfWarningDisabled (t as Object)
    test = setup_testBriteLogger()

    'GIVEN'
    test.SUT.setLevel(test.SUT.LEVEL.OFF)

    'WHEN'
    test.SUT.setLevel(test.SUT.LEVEL.ALL + 1)

    'THEN'
    t.assertEqual("", FakePrint().getPrint())

    teardown_testBriteLogger()
end sub
