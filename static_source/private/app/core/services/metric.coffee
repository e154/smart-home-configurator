angular
.module('appServices')
.factory 'Metric', ['$resource', ($resource) ->
  $resource '/api/v1/metric/:id', {id: '@id'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.metric || data

    create:
      method: 'POST'
      responseType: 'json'

    update:
        method: 'PUT'

    delete:
      method: 'DELETE'

    all:
      url: '/api/v1/metrics'
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.items || []

]
