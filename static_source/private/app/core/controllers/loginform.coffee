###*
# Created by delta54 on 09.11.14.
###

angular
.module('appControllers')
.controller 'loginFormCtrl', ['$scope','Auth','authService','Message','$base64','$http'
($scope, Auth, authService, Message, $base64, $http) ->

  $scope.user = new Auth {
    email: '',
    password: ''
  }

  $scope.auth = ->

    app.access_token = null

    success =(result)->
      console.log result
      app.access_token = result.data.access_token || null

      authService.loginConfirmed()
      $scope.closeThisDialog()

    error = (result)->
      Message result.data.status, result.data.message

    headers =
      "X-Requested-With": "XMLHttpRequest"
      Authorization: "Basic " + $base64.encode("#{$scope.user.email}:#{$scope.user.password}")

    $http.post('/signin', {}, {headers: headers}).then success, error

]
