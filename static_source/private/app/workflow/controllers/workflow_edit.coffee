angular
.module('appControllers')
.controller 'workflowEditCtrl', ['$scope', 'Message', '$stateParams', 'Workflow', '$state', '$translate'
($scope, Message, $stateParams, Workflow, $state, $translate) ->
  vm = this

  Workflow.show {id: $stateParams.id}, (workflow)->
    vm.workflow = workflow

  vm.remove =->
    $translate('remove the node?').then (text)->
      if confirm text
        remove()

  remove =->
    success =->
      $state.go("dashboard.workflow.index")
    error =(result)->
      Message result.data.status, result.data.message
    vm.workflow.$delete success, error

  vm.submit =->
    success =(data)->
      $state.go("dashboard.workflow.show", {id: data.id})

    error =(result)->
      Message result.data.status, result.data.message

    vm.workflow.$update(success, error)

  vm
]