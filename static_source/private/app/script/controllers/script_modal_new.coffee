angular
.module('appControllers')
.controller 'scriptModalNewCtrl', ['$scope', 'Notify', 'Script', '$state', 'Message', '$rootScope'
($scope, Notify, Script, $state, Message, $rootScope) ->
  vm = this

  $scope.ace_options = angular.copy $rootScope.ace_options

  vm.script = new Script
    name: "New script"
    lang: "coffeescript"
    description: ""
    source: ""

  vm.submitScript =->
    success =(script)->
      $scope.$parent.setScript(script)
      Notify 'success', 'The script was successfully created', 1

    error =(result)->
      Message result.data.status, result.data.message

    vm.script.$create(success, error)

  $scope.$watch 'script.script.lang', (lang)->
    return if !lang || lang == ''
    switch lang
      when 'javascript'
        $scope.ace_options.mode = 'javascript'
      when 'coffeescript'
        $scope.ace_options.mode = 'coffee'
      when 'ts'
        $scope.ace_options.mode = 'typescript'

  vm.exec =->
    success =(data)->
      vm.script.result = vm.script.result.replace(/(\\n)/g, '<br>')

    error =(result)->
      Message result.data.status, result.data.message

    vm.script.$exec success, error

  vm
]