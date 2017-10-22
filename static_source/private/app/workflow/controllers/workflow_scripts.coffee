angular
.module('appControllers')
.controller 'workflowScriptsCtrl', ['$scope', 'Message', '$stateParams', 'Workflow', '$state', 'Notify'
($scope, Message, $stateParams, Workflow, $state, Notify) ->
  vm = this

  vm.submit =->
    console.log $scope.workflow.workflow
    success =(data)->
      Notify 'success', 'Connection successfully updated', 3
    error =(result)->
      Message result.data.status, result.data.message

    Workflow.update $scope.workflow.workflow, success, error

  vm
]