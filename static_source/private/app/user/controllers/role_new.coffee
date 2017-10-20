angular
.module('appControllers')
.controller 'roleNewCtrl', ['$scope', 'Notify', 'Role', '$stateParams', '$state', '$http', 'Message', 'RoleSelect2'
($scope, Notify, Role, $stateParams, $state, $http, Message, RoleSelect2) ->


  $scope.role = new Role {
    name: ''
    description: ''
  }

  $scope.roles = []
  $scope.refreshRoles = RoleSelect2 (roles)-> $scope.roles = roles

  $scope.create =->
    success =(role)->
      Notify 'success', 'Role successfully created', 3
      $state.go 'dashboard.role.edit', {name: role.name}
    error =(result)->
      Message result.data.status, result.data.message
    $scope.role.$create success, error
]