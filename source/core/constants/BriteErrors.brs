'////////////////////
'/// Brite Errors ///
'////////////////////
'
' @author Jérémy Lourenço <https://github.com/jlourenc>
'
function BriteErrors () as Object

    if IsInvalid(m.BriteErrors)

        m.BriteErrors = {

            '//////////////////
            '/// PUBLIC API ///
            '//////////////////

            BRITE_CREATE_ERROR_ID_DEFINED: "This instance is already a brite. Can't be created again."
            BRITE_DESTROY_ERROR_ID_NOT_DEFINED: "This instance is not a brite. Can't destroy it."
            BRITE_ERROR_BRITE_SECTION_NOT_DEFINED: "No brite section defined. Can't be handled."
            BRITE_ERROR_NOT_AN_ASSOCIATIVE_ARRAY: "This instance is not an associative array. Can't be handled."
            BRITE_ERROR_TYPE_NOT_DEFINED: "No type defined. Can't be handled."

            BRITE_EVENT_DISPATCHER: {
                EVENT_LISTENER_ALREADY_DEFINED: "This event listener is already defined. Can't add."
                EVENT_LISTENER_NOT_DEFINED: "This event listener has not been defined. Can't remove."
                DISPATCH_NO_EVENT_LISTENER_DEFINED: "No event listener defined for this event. Can't dispatch."
                DISPATCH_LISTENER_UNDEFINED: "Listener undefined. Can't dispatch"
            }

            BRITE_LOGGER: {
                UNKNOWN_DEBUG_LEVEL: "Unknown debug level."
                INVALID_ARGUMENTS: "Invalid arguments."
            }
        }

    end if

    return m.BriteErrors

end function
