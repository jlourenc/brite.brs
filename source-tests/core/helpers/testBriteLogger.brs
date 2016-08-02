'unit-test: core/helpers/BriteLogger'

'/////////////
'/// SETUP ///
'/////////////

function setup_testBriteLogger () as Object
    return {
        SUT: CreateTestableBriteLogger()
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
