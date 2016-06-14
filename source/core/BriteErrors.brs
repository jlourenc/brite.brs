'////////////////////
'/// Brite Errors ///
'////////////////////
'
' @author Jérémy Lourenço <https://github.com/jlourenc>
'
function BriteErrors () as Object

    if not m.doesExist("briteErrors")

        m.briteErrors = {

            '//////////////////
            '/// PUBLIC API ///
            '//////////////////

            BRITE_CREATE_ERROR_ID_DEFINED: "This instance is already a brite. Can't be created again."
            BRITE_DESTROY_ERROR_ID_NOT_DEFINED: "This instance is not a brite. Can't destroy it."
            BRITE_ERROR_BRITE_SECTION_NOT_DEFINED: "No brite section defined. Can't be handled."
            BRITE_ERROR_NOT_AN_ASSOCIATIVE_ARRAY: "This instance is not an associative array. Can't be handled."
            BRITE_ERROR_TYPE_NOT_DEFINED: "No type defined. Can't be handled."
        }

    end if

    return m.briteErrors

end function
