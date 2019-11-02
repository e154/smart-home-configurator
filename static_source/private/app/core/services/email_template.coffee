angular
.module('appServices')
.factory 'EmailTemplate', ['$resource', ($resource) ->
  $resource '/api/v1/template/:name', {id: '@name'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.template || data

    create:
      url: '/api/v1/template'
      method: 'POST'

    update:
      method: 'PUT'

    delete:
      method: 'DELETE'

    all:
      url: '/api/v1/templates'
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.items || []

]
