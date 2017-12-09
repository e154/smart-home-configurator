angular.module('appConstants')
.factory 'EmailTemplateSelect2', ['$http', ($http)->
  (cb)->
    (query)->
      $http(
        method: 'GET'
        url: "/api/v1/email/template/search"
        params:
          query: query
          limit: 5
          offset: 0
      ).then (response)->
        cb(response.data.templates) if cb
]