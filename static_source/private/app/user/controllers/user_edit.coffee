angular
.module('appControllers')
.controller 'userEditCtrl', ['$scope', 'Notify', 'User', '$stateParams', 'Message', '$state', 'RoleSelect2', '$translate'
($scope, Notify, User, $stateParams, Message, $state, RoleSelect2, $translate) ->

  $scope.user = new User {id: $stateParams.id}
  meta = [
    {
      key: 'phone1'
      value: ''
    }
    {
      key: 'phone2'
      value: ''
    }
    {
      key: 'telegram'
      value: ''
    }
    {
      key: 'slack'
      value: ''
    }
  ]

  $scope.refreshRoles = RoleSelect2 (roles)-> $scope.roles = roles

  show =->
    success =(user)->
      if user.meta == null || user.meta.length == 0
        $scope.user.meta = meta
    error =->
      $state.go 'dashboard.user.index'
    $scope.user.$show success, error

  $scope.removeAvatar =->
    $scope.user.image = null

  $scope.update =->
    success =->
      $translate.use($scope.user.lang)
      Notify 'success', 'User successfully updated', 3
    error =(result)->
      Message result.data.status, result.data.message
    $scope.user.$update success, error

  $scope.remove =->
    $translate('Delete user?').then (text)=>
      return if !confirm text
      success =->
        $state.go 'dashboard.user.index'
      error =(result)->
        Message result.data.status, result.data.message
      $scope.user.$delete success, error

  show()

]