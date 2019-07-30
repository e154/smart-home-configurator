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

  vm.copy =->
    success =(data)->
      $state.go('dashboard.script.edit', {id: data.id})

    error =(result)->
      Message result.data.status, result.data.message

    Script.copy vm.script, success, error

  vm.exec =->
    success =(data)->
      if !data.result
        return
      vm.script.result = data.result.replace(/(\\n)/g, '<br>')

    error =(result)->
      Message result.data.status, result.data.message

    Script.exec vm.script, success, error

  vm.exec_src =->
    success =(data)->
      if !data.result
        return
      vm.script.result = data.result.replace(/(\\n)/g, '<br>')

    error =(result)->
      Message result.data.status, result.data.message

    Script.exec_src vm.script, success, error

  vm
]