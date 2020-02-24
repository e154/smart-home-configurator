angular
.module('appServices')
.factory 'Zigbee2mqtt', ['$resource', ($resource) ->
  $resource '/api/v1/zigbee2mqtt/:id', {id: '@id'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.device || data

    create:
      method: 'POST'
      responseType: 'json'

    update:
        method: 'PUT'

    delete:
      method: 'DELETE'

    all:
      url: '/api/v1/zigbee2mqtts'
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.items || []

]
