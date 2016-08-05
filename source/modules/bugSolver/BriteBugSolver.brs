'////////////////////////
'/// Brite Bug Solver ///
'////////////////////////
'
'@author: Jérémy Lourenço <https://github.com/jlourenc>
'
' @return {BriteBugSolver} singleton - the BriteBugSolver singleton
'
'
function BriteBugSolver () as Object

    if IsInvalid(m.BriteBugSolver)

        m.BriteBugSolver = {

            '//////////////////
            '/// PUBLIC API ///
            '//////////////////

            define: function (objDefLib as Object) as Void
                m._objectDefinitions = {}

                if IsAssociativeArray(objDefLib)
                    for each briteType in objDefLib
                        m._objectDefinitions.addReplace(briteType, {})

                        objDef = objDefLib[briteType]
                        if IsAssociativeArray(objDef)
                            for each key in objDef
                                m._defineMember(briteType, key, objDef[key])
                            end for
                        end if
                    end for
                end if
            end function


            fix: function (instance as Object) as Void
                objDef = m._objectDefinitions.lookupCi(instance.getBriteType())

                if objDef <> Invalid
                    for each memberId in objDef
                        instance.addReplace(memberId, objDef[memberId])
                    end for
                end if
            end function


            '//////////////////////////
            '/// PRIVATE PROPERTIES ///
            '//////////////////////////

            _TYPE: {
                FUNCTION: "function"
            }

            _objectDefinitions: {}


            '///////////////////////
            '/// PRIVATE METHODS ///
            '///////////////////////

            _defineMember: function (briteType as String, key as String, definition as Object) as Void
                if IsAssociativeArray(definition) AND IsString(definition.type) AND not IsInvalid(definition.value)
                    if m._TYPE.FUNCTION = lcase(definition.type)
                        eval("m._objectDefinitions[briteType][key] = " + definition.value)
                    else
                        m._objectDefinitions[briteType].addReplace(key, definition.value)
                    end if
                end if
            end function

        }

    end if

    return m.BriteBugSolver

end function
