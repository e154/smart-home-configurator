angular
.module('appControllers')
.controller 'scriptNewCtrl', ['$scope', 'Notify', 'Script', '$state', 'Message'
($scope, Notify, Script, $state, Message) ->
  vm = this

  vm.script = new Script({
    name: "New script"
    lang: "coffeescript"
    description: ""
    source: ""
  })

  vm.submit =->
    success =(data)->
      $state.go("dashboard.script.show", {id: data.id})

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