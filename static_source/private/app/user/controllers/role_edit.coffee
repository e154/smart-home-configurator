angular
.module('appControllers')
.controller 'roleEditCtrl', ['$scope', 'Notify','Role', '$stateParams', '$state', '$http', 'Message', 'RoleSelect2'
($scope, Notify, Role, $stateParams, $state, $http, Message, RoleSelect2) ->

  $scope.role = new Role {name: $stateParams.name}
  $scope.roles = []

  $scope.refreshRoles = RoleSelect2 (roles) -> $scope.roles = roles

  show =->
    success =->
    error =->
      $state.go 'dashboard.role.index'
    $scope.role.$show success, error

  $scope.remove =->
    return if !confirm('точно удалить эту роль?')
    success =->
      $state.go 'dashboard.role.index'
    error =(result)->
      Message result.data.status, result.data.message
    $scope.role.$delete success, error

  $scope.update =->
    success =->
      Notify('success', 'Роль успешно обновлена', 3)
    error =(result)->
      Message result.data.status, result.data.message
    $scope.role.$update success, error


  show()
]