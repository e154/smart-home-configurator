angular.module('appConstants')
.factory 'ScriptSelect2', ['$http', ($http)->
  (cb)->
    (query)->
      $http(
        method: 'GET'
        url: window.app_settings.server_url + "/api/v1/script/search"
        params:
          query: query
          limit: 5
          offset: 0
      ).then (response)->
        cb(response.data.scripts) if cb
]