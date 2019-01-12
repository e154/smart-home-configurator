angular.module('appConstants')
.factory 'NodeSelect2', ['$http', ($http)->
  (cb)->
    (query)->
      $http(
        method: 'GET'
        url: "/api/v1/nodes/search"
        params:
          query: query
          limit: 5
          offset: 0
      ).then (response)->
        cb(response.data.nodes) if cb
]