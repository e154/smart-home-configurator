angular
.module('appControllers')
.controller 'scriptCtrl', ['$scope', '$rootScope'
($scope, $rootScope) ->
  vm = this

  $scope.ace_options = angular.copy $rootScope.ace_options    

  vm
]