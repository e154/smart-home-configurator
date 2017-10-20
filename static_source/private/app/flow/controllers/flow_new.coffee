angular
.module('appControllers')
.controller 'flowNewCtrl', ['$scope', 'Notify', 'Flow', '$state', 'Message', 'Workflow', '$timeout', 'WorkflowSelect2', 'WorkflowScenarioSelect2'
($scope, Notify, Flow, $state, Message, Workflow, $timeout, WorkflowSelect2, WorkflowScenarioSelect2) ->
  vm = this

  $scope.flow = new Flow({
    name: "Процесс"
    status: "enabled"
    description: ""
    workflow: null
    scenario: null
  })

  $scope.submit =->
    success =(data)->
      Notify 'success', 'Process successfully created', 1
      $timeout ()->
        $state.go("dashboard.flow.show", {id: data.id})
      , 1000

    error =(result)->
      Message result.data.status, result.data.message

    $scope.flow.$create(success, error)

  $scope.workflows = []
  $scope.refreshWorkflows = WorkflowSelect2 (workflows)-> $scope.workflows = workflows

  $scope.scenarios = []
  get_workflow_id =-> $scope.flow.workflow?.id
  $scope.refreshScenarios = WorkflowScenarioSelect2 get_workflow_id, (scenarios)-> $scope.scenarios = scenarios

  $scope.$watch 'flow.workflow', (nv, ov)->
    return if nv == ov
    $scope.scenarios = []
    $scope.flow.scenario = null

  vm
]