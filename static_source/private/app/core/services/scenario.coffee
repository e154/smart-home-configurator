angular
.module('appServices')
.factory 'Scenario', ['$resource', ($resource) ->
  $resource '/api/v1/scenario/:id', {id: '@id'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.scenario || data

    create:
      method: 'POST'
      responseType: 'json'
      transformResponse: (data) ->
        data?.scenario || data

    update:
        method: 'PUT'
        responseType: 'json'
        transformResponse: (data) ->
          data?.scenario || data

    delete:
      method: 'DELETE'

    all:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.scenarios || []
]
