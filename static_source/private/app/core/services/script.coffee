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

    update:
      method: 'PUT'
      responseType: 'json'
      transformResponse: (data) ->
        @

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

    copy:
      url: '/api/v1/script/:id/copy'
      method: 'POST'
      responseType: 'json'

    exec_src:
      url: '/api/v1/script/:id/exec_src'
      method: 'POST'
      responseType: 'json'
]
