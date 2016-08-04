'/////////////////////////
'/// Brite Message Bus ///
'/////////////////////////
'
' @author Jérémy Lourenço <https://github.com/jlourenc>
'
function BriteMessageBus () as Object

    return {

        brite: {
            type: "BriteMessageBus"
            extends: BriteEventDispatcher()
        }

        '//////////////////
        '/// PUBLIC API ///
        '//////////////////

        dispatchEvent: function (eventType as String, eventPayload = Invalid as Object) as Void
            m._dispatchEvent(eventType, eventPayload)
        end function
    }

end function
