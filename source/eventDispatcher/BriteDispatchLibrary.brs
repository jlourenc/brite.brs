'//////////////////////////////
'/// Brite Dispatch Library ///
'//////////////////////////////
'
' @author Jérémy Lourenço <https://github.com/jlourenc>
'
function BriteDispatchLibrary () as Object

    if not m.doesExist("briteDispatchLibrary")

        m.briteDispatchLibrary = {

            '//////////////////
            '/// PUBLIC API ///
            '//////////////////

            add: function (dispatcherId as String, eventType as String, listenerId as String, handlerName as String) as Void
                dispatchers = m._dispatchersByListeners.lookup(listenerId)
                if dispatchers = Invalid
                    dispatchers = {}
                    m._dispatchersByListeners.addReplace(listenerId, dispatchers)
                end if

                dispatcher = dispatchers.lookup(dispatcherId)
                if dispatcher = Invalid
                    dispatcher = {}
                    dispatchers.addReplace(dispatcherId, dispatcher)
                end if

                dispatcher.addReplace(eventType + ":" + handlerName, Invalid)
            end function


            remove: function (dispatcherId as String, eventType as String, listenerId as String, handlerName as String) as Void
                dispatchers = m._dispatchersByListeners.lookup(listenerId)
                if dispatchers <> Invalid
                    dispatcher = dispatchers.lookup(dispatcherId)
                    if dispatcher <> Invalid
                        dispatcher.delete(eventType + ":" + handlerName)
                        if dispatcher.count() = 0
                            dispatchers.delete(dispatcherId)
                            if dispatchers.count() = 0
                                m._dispatchersByListeners.delete(listenerId)
                            end if
                        end if
                    end if
                end if
            end function


            clear: function (listener as String) as Void
                dispatchers = m._dispatchersByListeners[listener.getBriteId()]
                if dispatchers <> Invalid
                    for each dispatcherId in dispatchers
                        dispatcher = find(dispatcherId)
                        dispatches = dispatchers[dispatcherId]
                        for each dispatchId in dispatches
                            dispatch = dispatchId.split(":")
                            dispatcher.removeEventListener(dispatch[0], listener, dispatch[1])
                        end for
                    end for
                end if
            end function


            '//////////////////////////
            '/// PRIVATE PROPERTIES ///
            '//////////////////////////

            _dispatchersByListeners: {}

        }

    end if

    return m.briteDispatchLibrary

end function
