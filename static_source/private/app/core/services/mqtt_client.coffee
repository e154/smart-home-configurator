angular
.module('appServices')
.factory 'MqttClient', ['$resource', ($resource) ->
  $resource '/api/v1/mqtt/clients', {},
    show:
      url: '/api/v1/mqtt/client/:id'
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.client || data

    close:
      url: '/api/v1/mqtt/client/:id'
      method: 'DELETE'
      responseType: 'json'
      transformResponse: (data) ->
        data?.client || data

    unsubscribe:
      url: "/api/v1/mqtt/client/:id/topic"
      method: 'DELETE'
      responseType: 'json'

    all:
      url: '/api/v1/mqtt/clients'
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.items || []

    session:
      url: '/api/v1/mqtt/client/:id/session'
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.session || data
]
