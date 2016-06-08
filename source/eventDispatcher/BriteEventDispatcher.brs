'//////////////////////////////
'/// Brite Event Dispatcher ///
'//////////////////////////////
'
' @author Jérémy Lourenço <https://github.com/jlourenc>
'
function BriteEventDispatcher () as Object

    return {

        brite: {
            type: "BriteEventDispatcher"
        }
        briteEventDispatcher: true

        '//////////////////
        '/// PUBLIC API ///
        '//////////////////

        addEventListener: function (eventType as String, brite as Object, handlerName as String) as Void
            listeners = m._listeners.lookup(eventType)
            if listeners = Invalid
                listeners = {}
                m._listeners.addReplace(eventType, listeners)
            end if

            listeners.addReplace(brite.getBriteId() + ":" + handlerName, 0)
        end function


        removeEventListener: function (eventType as String, brite as Object, handlerName as String) as Void
            listeners = m._listeners.lookup(eventType)
            if listeners <> Invalid and listeners.delete(brite.getBriteId() + ":" + handlerName) and listeners.count() = 0
                m._listeners.delete(eventType)
            end if
        end function


        '//////////////////////////
        '/// PRIVATE PROPERTIES ///
        '//////////////////////////

        _listeners: {}


        '///////////////////////
        '/// PRIVATE METHODS ///
        '///////////////////////

        _dispatchEvent: function (eventType as String, eventPayload = Invalid as Dynamic) as Void
            listeners = m._listeners.lookup(eventType)

            if listeners <> Invalid
                for each listenerId in listeners
                    listener = listenerId.split(":")
                    brite = find(listener[0])
                    if brite <> Invalid
                        listeners[listenerId]++
                        brite[listener[1]](BriteEvent(eventType, eventPayload))
                    end if
                end for
            end if
        end function
    }

end function
