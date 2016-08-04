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

        '//////////////////
        '/// PUBLIC API ///
        '//////////////////

        addEventListener: function (eventType as String, brite as Object, handlerName as String) as Void
            listeners = m._listeners.lookup(eventType)
            listenerKey = m._generateListenerKey(brite, handlerName)

            if IsInvalid(listeners)
                listeners = {}
                m._listeners.addReplace(eventType, listeners)
            end if

            if listeners.doesExist(listenerKey)
                BriteLogger().warning(m.getBriteType(), BriteErrors().BRITE_EVENT_DISPATCHER.EVENT_LISTENER_ALREADY_DEFINED)
            else
                listeners.addReplace(listenerKey, 0)
                BriteDispatchLibrary().add(m.getBriteId(), eventType, brite.getBriteId(), handlerName)
            end if
        end function


        removeEventListener: function (eventType as String, brite as Object, handlerName as String) as Void
            listeners = m._listeners.lookup(eventType)

            if IsInvalid(listeners) or listeners.delete(m._generateListenerKey(brite, handlerName))
                BriteLogger().warning(m.getBriteType(), BriteErrors().BRITE_EVENT_DISPATCHER.EVENT_LISTENER_NOT_DEFINED)
            else
                if listeners.count() = 0 then m._listeners.delete(eventType)
                BriteDispatchLibrary().remove(m.getBriteId(), eventType, brite.getBriteId(), handlerName)
            end if
        end function


        '//////////////////////////
        '/// PRIVATE PROPERTIES ///
        '//////////////////////////

        _listeners: {}


        '///////////////////////
        '/// PRIVATE METHODS ///
        '///////////////////////

        _dispatchEvent: function (eventType as String, eventPayload = Invalid as Object) as Void
            listeners = m._listeners.lookup(eventType)

            if IsInvalid(listeners)
                BriteLogger().warning(m.getBriteType(), BriteErrors().BRITE_EVENT_DISPATCHER.DISPATCH_NO_EVENT_LISTENER_DEFINED)
            else
                for each listenerId in listeners
                    listener = listenerId.split(":")
                    brite = find(listener[0])
                    if IsInvalid(brite)
                        BriteLogger().error(m.getBriteType(), BriteErrors().BRITE_EVENT_DISPATCHER.DISPATCH_LISTENER_UNDEFINED)
                    else
                        listeners[listenerId] = listeners[listenerId] + 1
                        brite[listener[1]](BriteEvent(eventType, eventPayload))
                    end if
                end for
            end if
        end function

        _generateListenerKey: function (brite as Object, handlerName as String) as String
            return brite.getBriteId() + ":" + handlerName
        end function
    }

end function
