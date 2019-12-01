angular
.module('appServices')
.factory 'MqttClientSubscriptions', ['$resource', ($resource) ->
  (id)->
    $resource '/api/v1/mqtt/client/:id/subscriptions', {id: '@id'},
      all:
        url: "/api/v1/mqtt/client/#{id}/subscriptions"
        method: 'GET'
        responseType: 'json'
        transformResponse: (data) ->
          meta: data?.meta || {}
          items: data?.items || []

]
