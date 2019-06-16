angular
.module('appServices')
.factory 'ImageResource', ['$resource', ($resource) ->
  $resource '/api/v1/image/:id', {id: '@id'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.image || data

    create:
      method: 'POST'
      responseType: 'json'
      transformResponse: (data) ->
        data?.image || data

    update:
        method: 'PUT'
        responseType: 'json'

    delete:
      method: 'DELETE'

    all:
      url: '/api/v1/images'
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.items || []
]
