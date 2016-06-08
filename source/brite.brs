'///////////////////////////////
'/// Brite runtime functions ///
'///////////////////////////////

function new (instance as Object) as Object
    return Brite().new(instance)
end function


function delete (instance as Object) as Boolean
    return Brite().delete(instance)
end function


function find (briteId as String) as Object
    return Brite().find(briteId)
end function
