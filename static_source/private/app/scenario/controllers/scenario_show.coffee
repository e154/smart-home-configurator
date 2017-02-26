angular
.module('appControllers')
.controller 'scenarioShowCtrl', ['$scope', 'Notify', 'Scenario', '$stateParams', '$state', 'Message', '$http', 'ScenarioScript'
($scope, Notify, Scenario, $stateParams, $state, Message, $http, ScenarioScript) ->

  success = (scenario) ->
    $scope.scenario = scenario

  error =(result)->
    Message result.data.status, result.data.message

  Scenario.show {id: $stateParams.id}, success, error

  # select2
  # ------------------
  $scope.scripts = []
  $scope.refreshScripts = (query)->
    $http(
      method: 'GET'
      url: window.app_settings.server_url + "/api/v1/script/search"
      params:
        query: query
        limit: 5
        offset: 0
    ).then (response)->
      $scope.scripts = response.data.scripts

  $scope.remove_script =(script, index)->
    return if !script

    if !script.id
      $scope.scenario.scripts.splice(index, 1)
    else
      success =->
        $scope.scenario.scripts.splice(index, 1)
      error =(result)->
        Message result.data.status, result.data.message
      ScenarioScript.remove script, success, error
      return

  $scope.save_script =(script, index)->
    return if !script

    success =($script)->
      script.id = $script.id
      Notify 'success', 'Скрипт успешно сохранен', 3
    error =(result)->
      Message result.data.status, result.data.message

    if script.id
      ScenarioScript.update script, success, error
    else
      ScenarioScript.create script, success, error
    return

  new_script =->
    scenario: {id: $scope.scenario.id}
    state: ''
    script: null

  $scope.add_on_enter =->
    script = new_script()
    script.state = 'on_enter'
    $scope.scenario.scripts.push script

  $scope.add_on_exit =->
    script = new_script()
    script.state = 'on_exit'
    $scope.scenario.scripts.push script

]