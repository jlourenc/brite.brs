'unit-test: core/utilities/TypeUtils'


'/////////////
'/// TESTS ///
'/////////////

'IsBoolean'

sub testTypeUtils_IsBooleanWithBoolean (t as Object)
    t.assertTrue(IsBoolean(true))
end sub

sub testTypeUtils_IsBooleanWithRoBoolean (t as Object)
    t.assertTrue(IsBoolean(CreateObject("roBoolean")))
end sub

sub testTypeUtils_IsBooleanWithInvalid (t as Object)
    t.assertFalse(IsBoolean(Invalid))
end sub


'IsString'

sub testTypeUtils_IsStringWithString (t as Object)
    t.assertTrue(IsString("fooString"))
end sub

sub testTypeUtils_IsStringWithRoString (t as Object)
    t.assertTrue(IsString(CreateObject("roString")))
end sub

sub testTypeUtils_IsStringWithInvalid (t as Object)
    t.assertFalse(IsString(Invalid))
end sub


'IsInteger'

sub testTypeUtils_IsIntegerWithInteger (t as Object)
    t.assertTrue(IsInteger(1))
end sub

sub testTypeUtils_IsIntegerWithRoInteger (t as Object)
    t.assertTrue(IsInteger(CreateObject("roInt")))
end sub

sub testTypeUtils_IsIntegerWithInvalid (t as Object)
    t.assertFalse(IsInteger(Invalid))
end sub


'IsFloat'

sub testTypeUtils_IsFloatWithFloat (t as Object)
    t.assertTrue(IsFloat(1.2))
end sub

sub testTypeUtils_IsFloatWithRoFloat (t as Object)
    t.assertTrue(IsFloat(CreateObject("roFloat")))
end sub

sub testTypeUtils_IsFloatWithInvalid (t as Object)
    t.assertFalse(IsFloat(Invalid))
end sub


'IsDouble'

sub testTypeUtils_IsDoubleWithDouble (t as Object)
    t.assertTrue(IsDouble(1.2#))
end sub

sub testTypeUtils_IsDoubleWithRoDouble (t as Object)
    t.assertTrue(IsDouble(CreateObject("roDouble")))
end sub

sub testTypeUtils_IsDoubleWithInvalid (t as Object)
    t.assertFalse(IsDouble(Invalid))
end sub


'IsLongInteger'

sub testTypeUtils_IsLongIntegerWithLongInteger (t as Object)
    t.assertTrue(IsLongInteger(1&))
end sub

sub testTypeUtils_IsLongIntegerWithRoLongInteger (t as Object)
    t.assertTrue(IsLongInteger(CreateObject("roLongInteger")))
end sub

sub testTypeUtils_IsLongIntegerWithInvalid (t as Object)
    t.assertFalse(IsLongInteger(Invalid))
end sub


'IsFunction'

sub testTypeUtils_IsFunctionWithFunction (t as Object)
    myFunction = function () as Void
    end function
    t.assertTrue(IsFunction(myFunction))
end sub

sub testTypeUtils_IsFunctionWithRoFunction (t as Object)
    t.assertTrue(IsFunction(CreateObject("roFunction")))
end sub

sub testTypeUtils_IsFunctionWithInvalid (t as Object)
    t.assertFalse(IsFunction(Invalid))
end sub


'IsArray'

sub testTypeUtils_IsArrayWithArray (t as Object)
    t.assertTrue(IsArray([]))
end sub

sub testTypeUtils_IsArrayWithInvalid (t as Object)
    t.assertFalse(IsArray(Invalid))
end sub


'IsAssociativeArray'

sub testTypeUtils_IsAssociativeArrayWithAssociativeArray (t as Object)
    t.assertTrue(IsAssociativeArray({}))
end sub

sub testTypeUtils_IsAssociativeArrayWithInvalid (t as Object)
    t.assertFalse(IsAssociativeArray(Invalid))
end sub
