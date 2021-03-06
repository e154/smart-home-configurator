angular
.module('appServices')
.factory 'MapImageResource', ['$resource', ($resource) ->
  $resource '/api/v1/map_image/:id', {id: '@id'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.map_image || data

    create:
      method: 'POST'
      responseType: 'json'
      transformResponse: (data) ->
        data?.map_image || data

    update:
        method: 'PUT'
        responseType: 'json'

    delete:
      method: 'DELETE'

    all:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.map_images || []
]
