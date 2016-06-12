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

            add: function (listenerId as String, dispatcherId as String) as Void
                dispatchers = m._dispatchersByListeners[listenerId]
                if dispatchers = Invalid
                    m._dispatchersByListeners[listenerId] = {}
                    m._dispatchersByListeners[listenerId][dispatcherId] = 1
                else if dispatchers.doesExist(dispatcherId)
                    dispatchers[dispatcherId]++
                else
                    dispatchers[dispatcherId] = 1
                end if
            end function


            delete: function (listenerId as String, dispatcherId as String) as Void
                dispatchers = m._dispatchersByListeners[listenerId]
                if dispatchers <> Invalid and dispatchers.doesExist(dispatcherId)
                    if dispatchers[dispatcherId] > 1
                        dispatchers[dispatcherId]--
                    else
                        dispatchers.delete(dispatcherId)
                        if dispatchers.count() = 0 then m._dispatchersByListeners.delete(listenerId)
                    end if
                end if
            end function


            clear: function (listenerId as String) as Void
                dispatchers = m._dispatchersByListeners[listenerId]
                if dispatchers <> Invalid
                    for each dispatcherId in dispatchers
                        find(dispatcherId).removeAllEventListenersFromContext(listenerId)
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
