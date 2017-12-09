angular.module('appConstants')
.factory 'WorkflowSelect2', ['$http', ($http)->
  (cb)->
    (query)->
      $http(
        method: 'GET'
        url: "/api/v1/workflow/search"
        params:
          query: query
          limit: 5
          offset: 0
      ).then (response)->
        cb(response.data.workflows) if cb
]