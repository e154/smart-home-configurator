angular
.module('appControllers')
.controller 'workflowCtrl', ['$scope', 'Notify', 'Workflow', 'Stream', '$http'
($scope, Notify, Workflow, Stream, $http) ->
  vm = this

  $scope.scenarios = []
  $scope.refreshScenarios = (query)->
    $http(
      method: 'GET'
      url: window.app_settings.server_url + "/api/v1/scenario/search"
      params:
        query: query
        limit: 5
        offset: 0
    ).then (response)->
      $scope.scenarios = response.data.scenarios

  $scope.workflows = []
  $scope.getStatus = ->
    Stream.sendRequest("get.workflow.status", {})

  vm
]