angular.module('appConstants')
.factory 'Zigbee2mqttSelect2', ['$http', ($http)->
  (cb)->
    (query)->
      $http(
        method: 'GET'
        url: "/api/v1/zigbee2mqtts/search_device"
        params:
          query: query
          limit: 5
          offset: 0
      ).then (response)->
        cb(response.data.devices) if cb
]
