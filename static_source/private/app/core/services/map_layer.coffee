angular
.module('appServices')
.factory 'MapLayerResource', ['$resource', ($resource) ->
  $resource '/api/v1/map_layer/:id', {id: '@id'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.map_layer || data

    create:
      method: 'POST'
      responseType: 'json'
      transformResponse: (data) ->
        data?.map_layer || data

    update:
        method: 'PUT'
        responseType: 'json'

    sort:
      url: '/api/v1/map_layers/sort'
      method: 'PUT'
      responseType: 'json'

    delete:
      method: 'DELETE'

    all:
      url: '/api/v1/map_layers'
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.items || []
]
