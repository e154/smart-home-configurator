angular
.module('appControllers')
.controller 'scriptModalEditCtrl', ['$scope', 'Notify', 'Script', '$state', 'Message', '$rootScope'
($scope, Notify, Script, $state, Message, $rootScope) ->
  vm = this

  $scope.ace_options = angular.copy $rootScope.ace_options

  vm.script = new Script($scope.$parent.script)

  vm.submitScript =->
    success =(script)->
      $scope.$parent.setScript(script)
      Notify 'success', 'Script successfully saved', 1

    error =(result)->
      Message result.data.status, result.data.message

    vm.script.$update(success, error)

  $scope.$watch 'script.script.lang', (lang)->
    return if !lang || lang == ''
    switch lang
      when 'javascript'
        $scope.ace_options.mode = 'javascript'
      when 'coffeescript'
        $scope.ace_options.mode = 'coffee'
      when 'lua'
        $scope.ace_options.mode = 'lua'

  vm.exec =->
    success =(data)->

    error =(result)->
      Message result.data.status, result.data.message

    vm.script.$exec success, error

  vm
]