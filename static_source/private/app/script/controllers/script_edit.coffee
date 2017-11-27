angular
.module('appControllers')
.controller 'scriptEditCtrl', ['$scope', 'Message', '$stateParams', 'Script', '$state', 'Notify', '$translate'
($scope, Message, $stateParams, Script, $state, Notify, $translate) ->
  vm = this

  Script.show {id: $stateParams.id}, (script)->
    vm.script = script

  vm.remove =->
    $translate('exactly remove the node?').then (text)->
      if confirm text
        remove()

  remove =->
    success =->
      $state.go("dashboard.script.index")
    error =(result)->
      Message result.data.status, result.data.message
    vm.script.$delete success, error

  vm.submit =->
    success =(data)->
      Notify 'success', 'Script successfully saved', 3

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