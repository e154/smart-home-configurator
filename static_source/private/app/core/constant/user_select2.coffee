angular.module('appConstants')
.factory 'UserSelect2', ['$http', ($http)->
  (cb)->
    (query)->
      $http(
        method: 'GET'
        url: window.app_settings.server_url + "/api/v1/user/search"
        params:
          query: query
          limit: 5
          offset: 0
      ).then (response)->
        cb(response.data.users) if cb
]