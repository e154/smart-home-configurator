angular.module('appConstants')
.factory 'DeviceSelect2', ['$http', ($http)->
  (cb)->
    (query)->
      $http(
        method: 'GET'
        url: "/api/v1/device/search"
        params:
          query: query
          limit: 5
          offset: 0
      ).then (response)->
        cb(response.data.devices) if cb
]