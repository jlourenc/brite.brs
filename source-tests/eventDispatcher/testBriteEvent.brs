'unit-test: eventDispatcher/BriteEvent'


'/////////////
'/// SETUP ///
'/////////////

function setup_testBriteEvent () as Object
    return {
        SUT: BriteEvent
    }
end function


function teardown_testBriteEvent () as Void
end function


'/////////////
'/// TESTS ///
'/////////////


'getType

sub testBriteEvent_getType (t as Object)
    test = setup_testBriteEvent()

    'GIVEN'
    aType = "fooType"
    aPayload = Invalid

    'WHEN'
    val = test.SUT(aType, aPayload).getType()

    'THEN'
    t.assertEqual(val, aType)

    teardown_testBriteEvent()
end sub


'getPayload

sub testBriteEvent_getPayloadAsInvalid (t as Object)
    test = setup_testBriteEvent()

    'GIVEN'
    aType = "fooType"
    aPayload = Invalid

    'WHEN'
    val = test.SUT(aType, aPayload).getPayload()

    'THEN'
    t.assertInvalid(val)

    teardown_testBriteEvent()
end sub

sub testBriteEvent_getPayloadAsString (t as Object)
    test = setup_testBriteEvent()

    'GIVEN'
    aType = "fooType"
    aPayload = "fooPayload"

    'WHEN'
    val = test.SUT(aType, aPayload).getPayload()

    'THEN'
    t.assertEqual(val, aPayload)

    teardown_testBriteEvent()
end sub

sub testBriteEvent_getPayloadAsInteger (t as Object)
    test = setup_testBriteEvent()

    'GIVEN'
    aType = "fooType"
    aPayload = 0

    'WHEN'
    val = test.SUT(aType, aPayload).getPayload()

    'THEN'
    t.assertEqual(val, aPayload)

    teardown_testBriteEvent()
end sub

sub testBriteEvent_getPayloadAsBoolean (t as Object)
    test = setup_testBriteEvent()

    'GIVEN'
    aType = "fooType"
    aPayload = true

    'WHEN'
    val = test.SUT(aType, aPayload).getPayload()

    'THEN'
    t.assertEqual(val, aPayload)

    teardown_testBriteEvent()
end sub

sub testBriteEvent_getPayloadAsObject (t as Object)
    test = setup_testBriteEvent()

    'GIVEN'
    aType = "fooType"
    aPayload = {id: "fooId"}

    'WHEN'
    val = test.SUT(aType, aPayload).getPayload()

    'THEN'
    t.assertEqual(val, aPayload)

    teardown_testBriteEvent()
end sub
