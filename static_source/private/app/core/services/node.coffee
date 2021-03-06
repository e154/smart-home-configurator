angular
.module('appServices')
.factory 'Node', ['$resource', ($resource) ->
  $resource '/api/v1/node/:id', {id: '@id'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.node || data

    create:
      method: 'POST'
      responseType: 'json'

    update:
        method: 'PUT'

    delete:
      method: 'DELETE'

    all:
      url: '/api/v1/nodes'
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.items || []

]
