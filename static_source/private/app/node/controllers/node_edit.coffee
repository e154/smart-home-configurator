angular
.module('appControllers')
.controller 'nodeEditCtrl', ['$scope', 'Message', '$stateParams', 'Node', '$state', '$translate'
($scope, Message, $stateParams, Node, $state, $translate) ->
  vm = this

  Node.show {id: $stateParams.id}, (node)->
    vm.node = node

  vm.remove =->
    $translate('Delete this item').then (text)->
      if confirm text
        remove()

  remove =->
    success =->
      $state.go("dashboard.node.index")
    error =(result)->
      Message result.data.status, result.data.message
    vm.node.$delete success, error

  vm.submit =->
    success =(data)->
      $state.go("dashboard.node.show", {id: data.id})

    error =(result)->
      Message result.data.status, result.data.message

    vm.node.$update(success, error)

  vm
]