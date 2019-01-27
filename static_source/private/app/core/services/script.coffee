angular
.module('appServices')
.factory 'Script', ['$resource', ($resource) ->
  $resource '/api/v1/script/:id', {id: '@id'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.script || data

    create:
      method: 'POST'
      responseType: 'json'
      transformResponse: (data) ->
        data?.script || data

    update:
        method: 'PUT'
        responseType: 'json'
        transformResponse: (data) ->
          data?.script || data

    delete:
      method: 'DELETE'

    all:
      url: '/api/v1/scripts'
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.items || []

    exec:
      url: '/api/v1/script/:id/exec'
      method: 'POST'
      responseType: 'json'
      transformResponse: (data) ->
        script = data?.script || data
        script.result = data?.result || ""
        script
]
