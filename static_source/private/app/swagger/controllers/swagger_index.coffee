angular
.module('appControllers')
.controller 'swaggerIndexCtrl', ['$scope', 'Log', '$state', '$timeout', '$httpParamSerializer'
($scope, Log, $state, $timeout, $httpParamSerializer) ->

  $scope.swaggerUrl = "/api/v1/swagger/index.html"
]