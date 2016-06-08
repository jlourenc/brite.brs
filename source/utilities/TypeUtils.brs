' Check the variable type against the type Boolean
' @param {Object} variable - variable for which the type is checked
' @return {Boolean} isBoolean - whether the variable is a Boolean
'
function IsBoolean (variable as Object) as Boolean
    return type(variable, 3) = "roBoolean"
end function


' Check the variable type against the type String
' @param {Object} variable - variable for which the type is checked
' @return {Boolean} isString - whether the variable is of a String
'
function IsString (variable as Object) as Boolean
    return type(variable, 3) = "roString"
end function


' Check the variable type against the type Integer
' @param {Object} variable - variable for which the type is checked
' @return {Boolean} isInteger - whether the variable is an Integer
'
function IsInteger (variable as Object) as Boolean
    return type(variable, 3) = "roInteger"
end function


' Check the variable type against the type Float
' @param {Object} variable - variable for which the type is checked
' @return {Boolean} isFloat - whether the variable is a Float
'
function IsFloat (variable as Object) as Boolean
    return type(variable, 3) = "roFloat"
end function


' Check the variable type against the type Double
' @param {Object} variable - variable for which the type is checked
' @return {Boolean} isDouble - whether the variable is a Double
'
function IsDouble (variable as Object) as Boolean
    return type(variable, 3) = "roDouble"
end function


' Check the variable type against the type LongInteger
' @param {Object} variable - variable for which the type is checked
' @return {Boolean} isLongInteger - whether the variable is a LongInteger
'
function IsLongInteger (variable as Object) as Boolean
    return type(variable, 3) = "roLongInteger"
end function


' Check the variable type against the type Function
' @param {Object} variable - variable for which the type is checked
' @return {Boolean} isFunction - whether the variable is a Function
'
function IsFunction (variable as Object) as Boolean
    return type(variable, 3) = "roFunction"
end function


' Check the variable type against the type Array
' @param {Object} variable - variable for which the type is checked
' @return {Boolean} isArray - whether the variable is an Array
'
function IsArray (variable as Object) as Boolean
    return type(variable, 3) = "roArray"
end function


' Check the variable type against the type AssociativeArray
' @param {Object} variable - variable for which the type is checked
' @return {Boolean} isAssociativeArray - whether the variable is an AssociativeArray
'
function IsAssociativeArray (variable as Object) as Boolean
    return type(variable, 3) = "roAssociativeArray"
end function
