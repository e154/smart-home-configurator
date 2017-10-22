angular
.module('appControllers')
.controller 'flowEditCtrl', ['$scope', 'Message', '$stateParams', 'Flow', '$state', 'Workflow', '$timeout'
'log', 'Notify', 'Worker', '$rootScope', 'WorkflowSelect2', 'WorkflowScenarioSelect2', '$translate'
($scope, Message, $stateParams, Flow, $state, Workflow, $timeout, log, Notify, Worker, $rootScope
WorkflowSelect2, WorkflowScenarioSelect2, $translate) ->
  vm = this

  # vars
  $scope.callback = {}
  $scope.workflows = []
  $scope.scenarios = []
  $scope.flow = {}
  $scope.elementScripts = {}
  $scope.elementFlows = {}

  # watcher
  #------------------------------------------------------------------------------
  instance = $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams, options)->
    $translate('Are you sure you want to leave the editing process?').then (text)->
      if !confirm text
        event.preventDefault()
    $scope.$on('$destroy', instance);

  #------------------------------------------------------------------------------
  # workflow list
  #------------------------------------------------------------------------------
  $scope.refreshWorkflows = WorkflowSelect2 (workflows)-> $scope.workflows = workflows

  get_workflow_id =-> $scope.flow.workflow?.id
  $scope.refreshScenarios = WorkflowScenarioSelect2 get_workflow_id, (scenarios)-> $scope.scenarios = scenarios

#  $scope.$watch 'flow.workflow', (nv, ov)->
#    return if nv == ov || !nv
#    $scope.scenarios = []
#    $scope.flow.scenario = null

  #------------------------------------------------------------------------------
  # flow
  #------------------------------------------------------------------------------
  getFlow =->
    success = (flow) ->
      $scope.flow = flow
      if !$scope.flow?.workers
        $scope.flow.workers = []

      # scripts
      angular.forEach $scope.flow.objects, (object)->
        $scope.elementScripts[object.id] = object.script if object.script?.id?
        $scope.elementFlows[object.id] = object.flow_link if object.flow_link?

      $timeout ()->
        $scope.getStatus().then (result)->
          angular.forEach $scope.flows, (value, id)->
            if flow.id == parseInt(id, 10)
              $scope.flow.state = value
      , 500

    error = ->
      $state.go 'dashboard.flow.index'

    Flow.get_redactor {id: $stateParams.id}, success, error
    $scope.remove =->
      if confirm('точно удалить процесс?')
        remove()

  #------------------------------------------------------------------------------
  # remove
  #------------------------------------------------------------------------------
  remove =->
    $scope.$on('$destroy', instance);
    success =->
      $state.go("dashboard.flow.index")
    error =(result)->
      Message result.data.status, result.data.message
    $scope.flow.$delete success, error

  #------------------------------------------------------------------------------
  # save
  #------------------------------------------------------------------------------
  $scope.submit =->
    success =(data)->
      $scope.$on('$destroy', instance);
      Notify 'success', 'Schema saved successfully', 3

    error =(result)->
      Message result.data.status, result.data.message

    scheme = $scope.callback.save()
    $scope.flow.objects = scheme.objects || []

    # scripts & flows
    angular.forEach $scope.flow.objects, (object)->
      object.script = $scope.elementScripts[object.id] || null
      object.flow_link = $scope.elementFlows[object.id] || null

    $scope.flow.connectors = scheme.connectors || []
    Flow.update_redactor {id: $stateParams.id}, $scope.flow, success, error

  #------------------------------------------------------------------------------
  # init
  #------------------------------------------------------------------------------
  getFlow()

  vm
]