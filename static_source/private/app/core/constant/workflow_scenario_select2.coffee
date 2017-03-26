angular.module('appConstants')
.factory 'WorkflowScenarioSelect2', ['$http', ($http)->
  (cb)->
    (query)->
      $http(
        method: 'GET'
        url: window.app_settings.server_url + "/api/v1/workflow/scenario/search"
        params:
          query: query
          limit: 5
          offset: 0
      ).then (response)->
        cb(response.data.scenarios) if cb
]