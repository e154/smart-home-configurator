angular
.module('appControllers')
.controller 'scriptModalShowCtrl', ['$scope', '$rootScope'
($scope, $rootScope) ->
  vm = this

  vm.script = $scope.$parent.script

  $scope.ace_options = angular.extend {}, $rootScope.ace_options, readOnly: true

  switch vm.script.lang
    when 'javascript'
      $scope.ace_options.mode = 'javascript'
    when 'coffeescript'
      $scope.ace_options.mode = 'coffee'
    when 'ts'
      $scope.ace_options.mode = 'typescript'

  vm
]