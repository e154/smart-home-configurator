angular
.module('appControllers')
.controller 'workflowScenariosCtrl', ['$scope', 'Message', '$stateParams', 'Workflow', 'Notify'
($scope, Message, $stateParams, Workflow, Notify) ->

  vm = this
  vm.current = {}

  vm.addNew =->
    vm.current =
      name: 'New'
      system_name: 'New'
      scripts: []

  vm.update_scenario =(item)->
    return if !item.id?

    success =->
      $scope.workflow.workflow.scenario = item
      vm.current = angular.copy item
    error =(result)->
      Message result.data.status, result.data.message

    data =
      workflow_id: $scope.workflow.workflow.id
      id: item.id
    Workflow.update_scenario data, success, error

  vm.get_all_scenario =->
    success =(scenarios)->
      $scope.workflow.workflow.scenarios = angular.copy scenarios
      vm.cancel()
    error =(result)->
      Message result.data.status, result.data.message

    Workflow.scenario_all {workflow_id: $scope.workflow.workflow.id}, success, error

  vm.remove = ()->
    data = angular.copy vm.current
    data.workflow_id = $scope.workflow.workflow.id

    success =->
      Notify 'success', 'Сценарий успешно удалён', 5
      vm.get_all_scenario()
      vm.cancel()
    error =(result)->
      Message result.data.status, result.data.message

    Workflow.scenario_delete data, success, error

  vm.cancel =()->
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
        Notify 'success', 'Сценарий успешно обновлён', 5
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

  vm
]