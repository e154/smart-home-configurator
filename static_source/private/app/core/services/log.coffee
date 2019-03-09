angular
.module('appServices')
.factory 'Log', ['$resource', ($resource) ->
  $resource '/api/v1/log/:id', {id: '@id'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.log || data

    create:
      method: 'POST'
      responseType: 'json'
      transformResponse: (data) ->
        data?.log || data

    update:
        method: 'PUT'
        responseType: 'json'

    delete:
      method: 'DELETE'

    all:
      url: '/api/v1/logs'
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.items || []
]
