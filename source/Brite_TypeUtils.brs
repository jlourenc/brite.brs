' Brite Type Utils
'
' Utility functions to help check variables type
'
' @author Jérémy Lourenço <https://github.com/jlourenc>



' Check if the variable is of type Array
'
' @param {Object} var - variable to be checked
' @return {Boolean} isOfTypeArray

function Brite_IsArray (var as Object) as Boolean
    return type(var, 3) = "roArray"
end function


' Check if the variable is of type AssociativeArray
'
' @param {Object} var - variable to be checked
' @return {Boolean} isOfTypeAssociativeArray

function Brite_IsAssociativeArray (var as Object) as Boolean
    return type(var, 3) = "roAssociativeArray"
end function


' Check if the variable is of type Boolean
'
' @param {Object} var - variable to be checked
' @return {Boolean} isOfTypeBoolean

function Brite_IsBoolean (var as Object) as Boolean
    return type(var, 3) = "roBoolean"
end function


' Check if the variable is of type ByteArray
'
' @param {Object} var - variable to be checked
' @return {Boolean} isOfTypeByteArray

function Brite_IsByteArray (var as Object) as Boolean
    return type(var, 3) = "roByteArray"
end function


' Check if the variable is of type DateTime
'
' @param {Object} var - variable to be checked
' @return {Boolean} isOfTypeDateTime

function Brite_IsDateTime (var as Object) as Boolean
    return type(var, 3) = "roDateTime"
end function


' Check if the variable is of type Double
'
' @param {Object} var - variable to be checked
' @return {Boolean} isOfTypeDouble

function Brite_IsDouble (var as Object) as Boolean
    varType = type(var, 3)
    return varType = "roDouble" or varType = "Double"
end function


' Check if the variable is of type Float
'
' @param {Object} var - variable to be checked
' @return {Boolean} isOfTypeFloat

function Brite_IsFloat (var as Object) as Boolean
    return type(var, 3) = "roFloat"
end function


' Check if the variable is of type Function
'
' @param {Object} var - variable to be checked
' @return {Boolean} isOfTypeFunction

function Brite_IsFunction (var as Object) as Boolean
    return type(var, 3) = "roFunction"
end function


' Check if the variable is of type List
'
' @param {Object} var - variable to be checked
' @return {Boolean} isOfTypeList

function Brite_IsList (var as Object) as Boolean
    return type(var, 3) = "roList"
end function


' Check if the variable is of type LongInteger
'
' @param {Object} var - variable to be checked
' @return {Boolean} isOfTypeLongInteger

function Brite_IsLongInteger (var as Object) as Boolean
    return type(var, 3) = "LongInteger"
end function


' Check if the variable is of type Integer
'
' @param {Object} var - variable to be checked
' @return {Boolean} isOfTypeInteger

function Brite_IsInteger (var as Object) as Boolean
    return type(var, 3) = "roInt"
end function


' Check if the variable is of type Invalid
'
' @param {Object} var - variable to be checked
' @return {Boolean} isOfTypeInvalid

function Brite_IsInvalid (var as Object) as Boolean
    return type(var, 3) = "roInvalid"
end function


' Check if the variable is of type String
'
' @param {Object} var - variable to be checked
' @return {Boolean} isOfTypeString

function Brite_IsString (var as Object) as Boolean
    return type(var, 3) = "roString"
end function
