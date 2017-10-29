angular
.module('appControllers')
.controller 'userNewCtrl', ['$scope', 'Notify', 'User', 'Message', '$http', '$state', 'RoleSelect2'
($scope, Notify, User, Message, $http, $state, RoleSelect2) ->

  $scope.user = new User({
    nickname: 'johndoe'
    status: 'active'
    role:
      name: 'user'
    meta: [
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
    lang: 'en'
    first_name: 'John'
    last_name: 'Doe'
    email: 'john@e154.ru'

  })

  $scope.roles = []
  $scope.refreshRoles = RoleSelect2 (roles)-> $scope.roles = roles

  $scope.create =->
    success =(user)->
      Notify 'success', 'User successfully created', 3
      $state.go 'dashboard.user.edit', {id: user.id}
    error =(result)->
      Message result.data.status, result.data.message
    $scope.user.$create success, error
]