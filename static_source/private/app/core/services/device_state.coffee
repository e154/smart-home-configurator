angular
.module('appServices')
.factory 'DeviceState', ['$resource', ($resource) ->
  $resource '/api/v1/device_state/:id', {id: '@id'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.device_state || data

    create:
      method: 'POST'
      responseType: 'json'
      transformResponse: (data) ->
        data?.device_state || data

    update:
        method: 'PUT'
        responseType: 'json'

    delete:
      method: 'DELETE'

    get_by_device:
      url: '/api/v1/device_states/:id'
      method: 'GET'
      isArray: true
      responseType: 'json'
      transformResponse: (data) ->
        data?.device_states || data

    all:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.device_states || []
]
