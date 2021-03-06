angular
.module('appControllers')
.controller 'userIndexCtrl', ['$scope', 'User', '$state', '$filter', 'Notify', 'Message', '$translate', 'ifCan'
($scope, User, $state, $filter, Notify, Message, $translate, ifCan) ->

  tableCallback = {}
  $scope.options =
    perPage: 100
    resource: User
    columns: [
      {
        name: 'user.nickname'
        field: 'nickname'
        template: '<strong>{{item[field]}}</strong>'
      }
      {
        name: 'user.status'
        field: 'status'
        width: '70px'
      }
      {
        name: 'user.role'
        field: 'role_name'
        template: '<span>{{item[field]}}</span>'
        width: '100px'
      }
      {
        name: 'user.first_name'
        field: 'first_name'
        width: '120px'
      }
      {
        name: 'user.email'
        field: 'email'
        width: '120px'
      }
      {
        name: 'user.created_at'
        field: 'created_at'
        template: '<span>{{item[field] | readableDateTime}}</span>'
        width: '120px'
      }
      {
        name: 'user.updated_at'
        field: 'updated_at'
        template: '<span>{{item[field] | readableDateTime}}</span>'
        width: '120px'
      }
    ]
    menu:
      column: 0
      buttons: [
        {
          name: $filter('translate')('user.menu.show')
          clickCallback: ($event, user)->
            $event.preventDefault()
            $state.go('dashboard.user.show', {id: user.id})
            false
        }
        {
          name: $filter('translate')('user.menu.edit')
          clickCallback: ($event, user)->
            $event.preventDefault()
            $state.go('dashboard.user.edit', {id: user.id})
            false

          showIf: ()->
            ifCan.check({user: ['update']})
        }
        {
          name: $filter('translate')('user.menu.block')
          showIf: (user)->
            user.status != 'blocked'

          clickCallback: ($event, user)->
            $event.preventDefault()
            updateStatus(user, 'blocked')
            false

          showIf: ()->
            ifCan.check({user: ['update']})
        }
        {
          name: $filter('translate')('user.menu.unblock')
          showIf: (user)->
            user.status == 'blocked' && ifCan.check({user: ['update']})

          clickCallback: ($event, user)->
            $event.preventDefault()
            updateStatus(user, 'active')
            false
        }
        {
          name: $filter('translate')('user.menu.remove')
          showIf: (user)->
            user.status == 'blocked' && ifCan.check({user: ['update']})

          clickCallback: ($event, user)->
            $event.preventDefault()
            remove(user.id)
            false
        }
      ]
    callback: tableCallback
    onLoad: (result)->
    rows: (item)->

  remove =(id)->
    $translate('Delete user?').then (text)=>
      return if !confirm text
      success =->
        tableCallback.update()
        return
      error =(result)->
        Message result.data.status, result.data.message
      User.delete {id: id}, success, error
      return

  updateStatus =(user, status)->
    return if !status || status == ''
    user.status = status
    success =->
      Notify 'success', 'User successfully updated', 3
    error =(result)->
      Message result.data.status, result.data.message
    User.update_status user, success, error
]