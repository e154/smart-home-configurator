angular.module('appConstants')
.factory 'WorkflowScenarioSelect2', ['$http', ($http)->
  (get_workflow_id, cb)->
    (query)=>
      workflow_id = get_workflow_id()
      $http(
        method: 'GET'
        url: "/api/v1/workflow/#{workflow_id}/scenarios/search"
        params:
          query: query
          limit: 5
          offset: 0
      ).then (response)->
        cb(response.data.scenarios) if cb
]