angular
.module('appControllers')
.controller 'flowNewCtrl', ['$scope', 'Notify', 'Flow', '$state', 'Message', 'Workflow', '$timeout', 'WorkflowSelect2'
($scope, Notify, Flow, $state, Message, Workflow, $timeout, WorkflowSelect2) ->
  vm = this

  $scope.flow = new Flow({
    name: "Процесс"
    status: "enabled"
    description: ""
  })

  $scope.workflows = []
  success = (result)->
    console.log result
    $scope.workflows = result.items
  error = (result)->
    Message result.data.status, result.data.message
  Workflow.all {}, success, error

  $scope.submit =->
    success =(data)->
      Notify 'success', 'Процесс успешно создан', 1
      $timeout ()->
        $state.go("dashboard.flow.show", {id: data.id})
      , 1000

    error =(result)->
      Message result.data.status, result.data.message

    $scope.flow.$create(success, error)

  $scope.workflows = []
  $scope.refreshWorkflows = WorkflowSelect2 $scope.workflows

  vm
]