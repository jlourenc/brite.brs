'///////////////////
'/// Brite Event ///
'///////////////////
'
' @author Jérémy Lourenço <https://github.com/jlourenc>
'
function BriteEvent (type as String, payload as Dynamic) as Object

    return {

        '//////////////////
        '/// PUBLIC API ///
        '//////////////////

        getType: function () as String
            return m._type
        end function

        getPayload: function () as Dynamic
            return m._payload
        end function


        '//////////////////////////
        '/// PRIVATE PROPERTIES ///
        '//////////////////////////

        _type: type
        _payload: payload
    }

end function
