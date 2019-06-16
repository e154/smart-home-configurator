#
# servce:
# ifCan.check {map: ['read', 'update'], node: ['read', 'update']}
#

angular
.module('appServices')
.service 'ifCan', [ '$rootScope', ($rootScope) ->
  class ifCan

    user = null

    constructor: ->
      @user = window.app_settings.current_user

    check: (params) ->
      return false if !@user.role.access_list
      return true if @user.id == 1
      access_list = @user.role.access_list

      exist = false
      angular.forEach params, (rights, dir)->
        return if !access_list[dir]

        for right in rights
          if access_list[dir].indexOf(right) > -1
            exist = true

      return exist


  new ifCan()
]