'///////////////////
'/// Brite Debug ///
'///////////////////
'
' @author Jérémy Lourenço <https://github.com/jlourenc>
'
function BriteDebug () as Object

    if not m.doesExist("_briteDebug")

        m._briteDebug = {

            '//////////////////
            '/// PUBLIC API ///
            '//////////////////

            triggerError: function (error as String) as Void
                print "[Brite] " + error
            end function
        }

    end if

    return m._briteDebug

end function
