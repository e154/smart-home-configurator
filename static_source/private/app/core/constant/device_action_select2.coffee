angular.module('appConstants')
.factory 'DeviceActionSelect2', ['$http', ($http)->
  (cb)->
    (query)->
      $http(
        method: 'GET'
        url: window.app_settings.server_url + "/api/v1/device_action/search"
        params:
          query: query
          limit: 5
          offset: 0
      ).then (response)->
        cb(response.data.device_actions) if cb
]