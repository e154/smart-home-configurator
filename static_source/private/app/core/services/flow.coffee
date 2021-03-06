angular
.module('appServices')
.factory 'Flow', ['$resource', ($resource) ->
  $resource '/api/v1/flow/:id', {id: '@id'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.flow || data

    full:
      url: '/api/v1/flow/:id/full'
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.flow || data

    get_redactor:
      url: '/api/v1/flow/:id/redactor'
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.flow || data

    update_redactor:
      url: '/api/v1/flow/:id/redactor'
      method: 'PUT'

    workers:
      url: '/api/v1/flow/:id/workers'
      method: 'GET'
      transformResponse: (data) ->
        data?.workers || []

    create:
      method: 'POST'
      responseType: 'json'

    update:
        method: 'PUT'

    delete:
      method: 'DELETE'

    all:
      url: '/api/v1/flows'
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.items || []

]
