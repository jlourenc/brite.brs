'///////////////////
'/// Brite Debug ///
'///////////////////
'
' @author Jérémy Lourenço <https://github.com/jlourenc>
'
function BriteDebug () as Object

    if not m.doesExist("briteDebug")

        m.briteDebug = {

            '//////////////////
            '/// PUBLIC API ///
            '//////////////////

            triggerError: function (error as String) as Void
                print "[Brite] " + error
            end function
        }

    end if

    return m.briteDebug

end function
