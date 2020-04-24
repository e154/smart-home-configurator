angular.module('appConstants')
.factory 'MetricSelect2', ['$http', ($http)->
  (cb)->
    (query)->
      $http(
        method: 'GET'
        url: "/api/v1/metrics/search"
        params:
          query: query
          limit: 5
          offset: 0
      ).then (response)->
        cb(response.data.nodes) if cb
]
