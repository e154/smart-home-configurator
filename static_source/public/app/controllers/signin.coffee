angular
.module('appControllers')
.controller 'signinCtrl', ['$scope', '$http', '$timeout', '$base64'
($scope, $http, $timeout, $base64) ->

  $scope.email = ''
  $scope.password = ''
  $scope.error = null

  $scope.submit =->
    return if $scope.email == '' || $scope.password == ''

    success =()->
      window.location.reload()

    error =(error)->
      $scope.error = error.data.message
      $timeout ()->
        $scope.error = ''
      , 2000

    headers =
      Authorization: "Basic " + $base64.encode("#{$scope.email}:#{$scope.password}")

    $http.get('/signin', {headers: headers}).then success, error

]