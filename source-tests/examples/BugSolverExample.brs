function Divider () as Object
    return {
        brite: {
            type: "Divider"
        }

        divide: function (dividend as Float, divisor as Float) as Float
            return (dividend / divisor)
        end function
    }
end function

sub runBriteBugSolverExample ()
    BriteLogger().setLevel(BriteLogger().LEVEL.ALL)
    BriteBugSolver().define(ParseJson(getObjectDefinitionJson()))

    d = new(Divider())
    for i=10 to 0 step -1
        BriteLogger().info("Divider", "{0} divided by {1} = {2}", [10, i, d.divide(10, i)])
    end for
    delete(d)
end sub

function getObjectDefinitionJson() as String
    return FormatJson({
        divider: {
            divide: {
                type: "function"
                value: "function (dividend as Float, divisor as Float) as Float" + chr(10) + "if divisor = 0 then return 0" + chr(10) + "return (dividend / divisor)" + chr(10) + "end function"
            }
        }
    })
end function
