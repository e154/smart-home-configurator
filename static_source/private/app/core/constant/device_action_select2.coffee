angular.module('appConstants')
.factory 'DeviceActionSelect2', ['$http', ($http)->
  (cb)->
    (query)->
      $http(
        method: 'GET'
        url: "/api/v1/device_action1/search"
        params:
          query: query
          limit: 5
          offset: 0
      ).then (response)->
        cb(response.data.actions) if cb
]