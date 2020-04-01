angular
.module('appControllers')
.controller 'workflowScenariosCtrl', ['$scope', 'Message', '$stateParams', 'Workflow', 'Notify', '$translate', 'Stream', '$timeout'
($scope, Message, $stateParams, Workflow, Notify, $translate, Stream, $timeout) ->

  vm = this
  vm.current = {}
  vm.state = 'show' #show|add|edit|script_editor

  vm.addNew =->
    vm.state = 'add'
    vm.current =
      name: 'New scenario'
      system_name: 'scenario'
      scripts: []

  vm.update_scenario =(item)->
    return if !item.id?

    success =->
      #$scope.workflow.workflow.scenario = item
      #vm.current = angular.copy item
    error =(result)->
      Message result.data.status, result.data.message

    data =
      workflow_scenario_id: item.id
      workflow_id: $scope.workflow.workflow.id

    Workflow.update_scenario data, success, error

  vm.get_all_scenario =->
    success =(scenarios)->
      $scope.workflow.workflow.scenarios = angular.copy scenarios
      vm.state = 'show'
      vm.cancel()
    error =(result)->
      Message result.data.status, result.data.message

    Workflow.get_scenarios {workflow_id: $scope.workflow.workflow.id}, success, error

  vm.remove = ()->
    $translate('Delete this script?').then (text)=>
      return if !confirm text
      remove()

  remove = ->
    data = angular.copy vm.current
    data.workflow_id = $scope.workflow.workflow.id

    success =->
      Notify 'success', 'The script was successfully deleted', 5
      vm.get_all_scenario()
      vm.cancel()
    error =(result)->
      Message result.data.status, result.data.message

    Workflow.scenario_delete data, success, error

  vm.cancel =()->
    vm.state = 'show'
    vm.current = null

  vm.submit =->
    data = angular.copy vm.current
    data.workflow_id = $scope.workflow.workflow.id

    success =(scenario)->
      if !$scope.workflow.workflow.scenarios?
        $scope.workflow.workflow.scenarios = []

      if !data.id?
        $scope.workflow.workflow.scenarios.push scenario
      else
        Notify 'success', 'Successfully updated script', 5

      vm.get_all_scenario()


    error =(result)->
      Message result.data.status, result.data.message

    return if data.system_name == '' || data.name == ''

    if !data?.id?
      Workflow.scenario_create data, success, error
    else
      Workflow.scenario_update data, success, error

  vm.show =(item)->
    success =(result)->
      result.scripts = [] if !result.scripts
      vm.current = result
    error =(result)->
      Message result.data.status, result.data.message
    data =
      workflow_id: $scope.workflow.workflow.id
      id: item.id
    Workflow.scenario_show data, success, error

  Stream.subscribe 'dashboard.telemetry', 'workflows', (data)->
    if data.hasOwnProperty('workflows')
      if data.workflows.status.hasOwnProperty($scope.workflow.workflow.id)
        scenarioId = data.workflows.status[$scope.workflow.workflow.id]['scenario_id']
        for scenario, i in $scope.workflow.workflow.scenarios
          if scenario.id == scenarioId
            console.log "change workflow scenario to #{scenario.id}"
            $scope.workflow.workflow.scenario = angular.copy scenario
            vm.current = angular.copy scenario
            $timeout ()->
              $scope.$apply()

  $scope.$on '$stateChangeSuccess', ()->
    Stream.unsubscribe 'dashboard.telemetry', 'workflows'

  vm
]
