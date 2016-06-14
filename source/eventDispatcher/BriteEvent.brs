'///////////////////
'/// Brite Event ///
'///////////////////
'
'BriteEvent is the object dispatched by a BriteEventDispatcher on dispatch.
'It wraps the event type and payload, which are accessible through its API.
'
'@author: Jérémy Lourenço <https://github.com/jlourenc>
'
'@param {String} t - the event type
'@param {Dynamic} p - the event payload
'
'@return {Object} BriteEvent
'
'@see BriteEventDispatcher
'
function BriteEvent (t as String, p as Dynamic) as Object

    return {

        '//////////////////
        '/// PUBLIC API ///
        '//////////////////

        'Gets the event type.
        '
        '@return {String} eventType
        '
        getType: function () as String
            return m._type
        end function


        'Gets the event payload.
        '
        '@return {Dynamic} eventPayload
        '
        getPayload: function () as Dynamic
            return m._payload
        end function


        '//////////////////////////
        '/// PRIVATE PROPERTIES ///
        '//////////////////////////

        _type: t
        _payload: p
    }

end function
