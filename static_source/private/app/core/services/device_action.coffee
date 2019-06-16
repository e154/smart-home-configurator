angular
.module('appServices')
.factory 'DeviceAction', ['$resource', ($resource) ->
  $resource '/api/v1/device_action/:id', {id: '@id'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data

    create:
      method: 'POST'
      responseType: 'json'

    update:
        method: 'PUT'

    delete:
      method: 'DELETE'

    get_by_device:
      url: '/api/v1/device_actions/:id'
      method: 'GET'
      isArray: true
      responseType: 'json'
      transformResponse: (data) ->
        data
]
