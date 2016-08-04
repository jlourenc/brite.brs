'///////////////////
'/// Brite Event ///
'///////////////////
'
'BriteEvent is an object dispatched by a BriteEventDispatcher on dispatch.
'It wraps the event type and payload, which are accessible through its API.
'
'@author: Jérémy Lourenço <https://github.com/jlourenc>
'
'@param {String} t - the event type
'@param {Object} p - the event payload
'
'@return {Object} BriteEvent
'
'@see BriteEventDispatcher
'
function BriteEvent (t as String, p as Object) as Object

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
        '@return {Object} eventPayload
        '
        getPayload: function () as Object
            return m._payload
        end function


        '//////////////////////////
        '/// PRIVATE PROPERTIES ///
        '//////////////////////////

        _type: t
        _payload: p
    }

end function
