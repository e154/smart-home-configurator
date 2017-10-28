#
# servce:
# ifCan.check {map: ['read', 'update'], node: ['read', 'update']}
#

angular
.module('appServices')
.service 'ifCan', [ '$rootScope', ($rootScope) ->
  class ifCan

    constructor: ->

    check: (params) ->
      return false if !app.current_user.role.access_list
      access_list = app.current_user.role.access_list

      exist = false
      angular.forEach params, (rights, dir)->
        return if !access_list[dir]

        for right in rights
          if access_list[dir].indexOf(right) > -1
            exist = true

      return exist


  new ifCan()
]