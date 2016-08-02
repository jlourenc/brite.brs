' Check the variable type against the type Boolean
' @param {Object} var - variable for which the type is checked
' @return {Boolean} isBoolean - whether the variable is a Boolean
'
function IsBoolean (var as Object) as Boolean
    return type(var, 3) = "roBoolean"
end function


' Check the variable type against the type Invalid
' @param {Object} var - variable for which the type is checked
' @return {Boolean} isInvalid - whether the variable is a Boolean
'
function IsInvalid (var as Object) as Boolean
    return type(var, 3) = "roInvalid"
end function


' Check the variable type against the type String
' @param {Object} var - variable for which the type is checked
' @return {Boolean} isString - whether the variable is of a String
'
function IsString (var as Object) as Boolean
    return type(var, 3) = "roString"
end function


' Check the variable type against the type Integer
' @param {Object} var - variable for which the type is checked
' @return {Boolean} isInteger - whether the variable is an Integer
'
function IsInteger (var as Object) as Boolean
    return type(var, 3) = "roInt"
end function


' Check the variable type against the type Float
' @param {Object} var - variable for which the type is checked
' @return {Boolean} isFloat - whether the variable is a Float
'
function IsFloat (var as Object) as Boolean
    return type(var, 3) = "roFloat"
end function


' Check the variable type against the type Double
' @param {Object} var - variable for which the type is checked
' @return {Boolean} isDouble - whether the variable is a Double
'
function IsDouble (var as Object) as Boolean
    return type(var, 3) = "roDouble" or type(var, 3) = "Double"
end function


' Check the variable type against the type LongInteger
' @param {Object} var - variable for which the type is checked
' @return {Boolean} isLongInteger - whether the variable is a LongInteger
'
function IsLongInteger (var as Object) as Boolean
    return type(var, 3) = "LongInteger"
end function


' Check the variable type against the type Function
' @param {Object} var - variable for which the type is checked
' @return {Boolean} isFunction - whether the variable is a Function
'
function IsFunction (var as Object) as Boolean
    return type(var, 3) = "roFunction"
end function


' Check the variable type against the type Array
' @param {Object} var - variable for which the type is checked
' @return {Boolean} isArray - whether the variable is an Array
'
function IsArray (var as Object) as Boolean
    return type(var, 3) = "roArray"
end function


' Check the variable type against the type AssociativeArray
' @param {Object} var - variable for which the type is checked
' @return {Boolean} isAssociativeArray - whether the variable is an AssociativeArray
'
function IsAssociativeArray (var as Object) as Boolean
    return type(var, 3) = "roAssociativeArray"
end function
