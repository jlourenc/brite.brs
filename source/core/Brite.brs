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

                    type = instance[m._KEYWORD.BRITE][m._KEYWORD.EXTENDS]
                    instance.delete(m._KEYWORD.BRITE)

                    id = m._registerBrite(type)

                    m._defineIdGetter(instance, id)
                    m._defineTypeGetter(instance, type)
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
                else if not IsFunction(instance.getBriteId) or not IsFunction(instance.getBriteType
                    BriteDebug().triggerError(BriteErrors().BRITE_DESTROY_ERROR_ID_NOT_DEFINED)
                else
                    deleted = m._brites.delete(instance.getBriteId())
                    if deleted then m._briteTypes[instance.getBriteType()].objectCount--
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

            _registerBrite: function (type as String) as String
                briteType = m._briteTypes[type]

                if briteType = Invalid
                    briteType = {idCount: 1, objectCount: 1}
                    m._briteTypes[type] = briteType
                else
                    briteType.idCount++
                    briteType.objectCount++
                end if

                id = type + (briteType.idCount).toStr()
                m._brites[id] = brite

                return id
            end if

            _defineIdGetter: function (instance as Object, id as String) as Void
                eval("instance.getBriteId = function () as String" + chr(10) + "return " + chr(42) + id + chr(42) + chr(10) + "end function")
            end function

            _defineTypeGetter: function (instance as Object, type as String) as Void
                eval("instance.getBriteType = function () as String" + chr(10) + "return " + chr(42) + type + chr(42) + chr(10) + "end function")
            end function
        }

    end if

    return m.brite

end function
