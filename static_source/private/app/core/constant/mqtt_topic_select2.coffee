angular.module('appConstants')
.factory 'MqttTopicSelect2', ['$http', ($http)->
  (cb)->
    (query)->
      $http(
        method: 'GET'
        url: "/api/v1/mqtt/search_topic"
        params:
          query: query
          limit: 5
          offset: 0
      ).then (response)->
        cb(response.data.subscriptions) if cb
]