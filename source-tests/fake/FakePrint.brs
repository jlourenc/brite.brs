function FakePrint () as Object

    if IsInvalid(m.FakePrint)

        m.FakePrint = {

            '//////////////////
            '/// PUBLIC API ///
            '//////////////////

            setPrint: function (message as String) as Void
                m._print = message
            end function

            getPrint: function () as String
                return m._print
            end function

            dispose: function () as Void
                GetGlobalAA().FakePrint = Invalid
            end function


            '//////////////////////////
            '/// PRIVATE PROPERTIES ///
            '//////////////////////////

            _print: ""
        }

    end if

    return m.FakePrint
end function
