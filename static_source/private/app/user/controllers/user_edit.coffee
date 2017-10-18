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
      key: 'phone3'
      value: ''
    }
    {
      key: 'autograph'
      value: ''
    }
  ]

  $scope.refreshRoles = RoleSelect2 (roles)-> $scope.roles = roles

  show =->
    success =(user)->
      if user.meta.length == 0
        $scope.user.meta = meta
    error =->
      $state.go 'dashboard.user.index'
    $scope.user.$show success, error

  $scope.removeAvatar =->
    $scope.user.avatar = null

  $scope.update =->
    success =->
      $translate.use($scope.user.lang)
      Notify 'success', 'Пользователь  успешно обновлён', 3
    error =(result)->
      Message result.data.status, result.data.message
    $scope.user.$update success, error

  $scope.remove =->
    return if !confirm('точно удалить пользователя?')
    success =->
      $state.go 'dashboard.user.index'
    error =(result)->
      Message result.data.status, result.data.message
    $scope.user.$delete success, error

  show()

]