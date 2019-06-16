angular.module('appConstants')
.factory 'RoleSelect2', ['$http', ($http)->
  (cb)->
    (query)->
      $http(
        method: 'GET'
        url: "/api/v1/roles/search"
        params:
          query: query
          limit: 5
          offset: 0
      ).then (response)->
        cb(response.data.roles) if cb
]