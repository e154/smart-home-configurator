angular.module('appConstants')
.factory 'MapZoneSelect2', ['$http', ($http)->
  (cb)->
    (query)->
      $http(
        method: 'GET'
        url: "/api/v1/map_zone/search"
        params:
          query: query
          limit: 5
          offset: 0
      ).then (response)->
        cb(response.data.zones) if cb
]