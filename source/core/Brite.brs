'/////////////
'/// Brite ///
'/////////////
'
' The brite singleton is used to store all the brites instanciated by each application.
' It must only be used by the Brite framework. No application should be using it directly.
'
' @author Jérémy Lourenço <https://github.com/jlourenc>
'
function Brite () as Object

    if not m.doesExist("brite")

        m.brite = {

            '//////////////////
            '/// PUBLIC API ///
            '//////////////////

            ' Define the specified instance as a brite
            '
            ' @param {Object} instance - the future brite object
            ' @return {Object} instance - the new brite object
            '
            new: function (instance as Object) as Object
                inheritance = []

                parent = instance
                while m._doesContainBriteDefinition(parent)
                    inheritance.push(parent)
                    if IsAssociativeArray(parent[m._KEYWORD.BRITE][m._KEYWORD.EXTENDS])
                        parent = parent[m._KEYWORD.BRITE][m._KEYWORD.EXTENDS]
                    else
                        parent = Invalid
                        exit while
                    end if
                end while

                if parent = Invalid
                    instance = {}
                    while inheritance.count() > 0
                        instance.append(inheritance.pop())
                    end while

                    bType = instance[m._KEYWORD.BRITE][m._KEYWORD.EXTENDS]
                    instance.delete(m._KEYWORD.BRITE)

                    bId = m._registerBrite(bType)

                    m._defineIdGetter(instance, bId)
                    m._defineTypeGetter(instance, bType)
                    m._defineDispose(instance)
                end if

                return instance
            end function


            ' Delete the specified brite
            '
            ' @param {Object} instance - the brite object
            ' @return {Boolean} deleted - whether the brite has been deleted
            '
            delete: function (instance as Object) as Boolean
                deleted = false

                if not IsAssociativeArray(instance)
                    BriteDebug().triggerError(BriteErrors().BRITE_ERROR_NOT_AN_ASSOCIATIVE_ARRAY)
                else if not IsFunction(instance.getBriteId) or not IsFunction(instance.getBriteType)
                    BriteDebug().triggerError(BriteErrors().BRITE_DESTROY_ERROR_ID_NOT_DEFINED)
                else
                    deleted = m._brites.delete(instance.getBriteId())
                    if deleted
                        BriteDispatchLibrary().clear(instance.getBriteId())
                        instance.disposeBrite()
                        m._briteTypes[instance.getBriteType()].objectCount--
                    end if
                end if

                return deleted
            end function


            ' Retrieves the brite with the specified brite id if it exists
            '
            ' @param {string} id - the id of the brite to retrieve
            ' @return {object} brite - the retrieved brite or Invalid
            '
            find: function (id as Object) as Object
                return m._brites[id]
            end function


            '//////////////////////////
            '/// PRIVATE PROPERTIES ///
            '//////////////////////////

            _KEYWORD: {
                BRITE: "brite",
                EXTENDS: "extends",
                TYPE: "type",
            }

            _brites: CreateObject("roAssociativeArray")
            _briteTypes: CreateObject("roAssociativeArray")


            '///////////////////////
            '/// PRIVATE METHODS ///
            '///////////////////////

            _doesContainBriteDefinition: function (instance as Object) as Boolean
                briteDef = true

                if not IsAssociativeArray(instance)
                    BriteDebug().triggerError(BriteErrors().BRITE_ERROR_NOT_AN_ASSOCIATIVE_ARRAY)
                    briteDef = false
                else if not IsAssociativeArray(instance[m._KEYWORD.BRITE])
                    BriteDebug().triggerError(BriteErrors().BRITE_ERROR_BRITE_SECTION_NOT_DEFINED)
                    briteDef = false
                else if not IsString(instance[m._KEYWORD.BRITE][m._KEYWORD.TYPE])
                    BriteDebug().triggerError(BriteErrors().BRITE_ERROR_TYPE_NOT_DEFINED)
                    briteDef = false
                end if

                return briteDef
            end function

            _registerBrite: function (bType as String) as String
                briteType = m._briteTypes[bType]

                if briteType = Invalid
                    briteType = {idCount: 1, objectCount: 1}
                    m._briteTypes[bType] = briteType
                else
                    briteType.idCount++
                    briteType.objectCount++
                end if

                bId = bType + (briteType.idCount).toStr()
                m._brites[bId] = brite

                return id
            end function

            _defineIdGetter: function (instance as Object, bId as String) as Void
                eval("instance.getBriteId = function () as String" + chr(10) + "return " + chr(42) + bId + chr(42) + chr(10) + "end function")
            end function

            _defineTypeGetter: function (instance as Object, bType as String) as Void
                eval("instance.getBriteType = function () as String" + chr(10) + "return " + chr(42) + bType + chr(42) + chr(10) + "end function")
            end function

            _defineDispose: function (instance as Object) as Void
                instance.disposeBrite = function () as Void
                    if IsFunction(m._dispose) then m._dispose()
                end function
            end function
        }

    end if

    return m.brite

end function
