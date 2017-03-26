angular.module('appConstants')
.factory 'WorkflowScenarioSelect2', ['$http', ($http)->
  (get_workflow_id, cb)->
    (query)=>
      workflow_id = get_workflow_id()
      $http(
        method: 'GET'
        url: window.app_settings.server_url + "/api/v1/workflow/#{workflow_id}/scenario/search"
        params:
          query: query
          limit: 5
          offset: 0
      ).then (response)->
        cb(response.data.scenarios) if cb
]