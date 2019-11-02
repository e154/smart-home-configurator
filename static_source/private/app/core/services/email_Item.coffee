angular
.module('appServices')
.factory 'EmailItem', ['$resource', ($resource) ->
  $resource '/api/v1/template_item/:name', {name: '@name'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.item || data  

    create:
      method: 'POST'
      responseType: 'json'

    update:
      method: 'PUT'

    delete:
      method: 'DELETE'

    items:
      url: '/api/v1/template_items'
      method: 'GET'

    get_tree:
      url: '/api/v1/template_items/tree'
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.tree || data

    update_tree:
      url: '/api/v1/template_items/tree'
      method: 'POST'

    update_status:
      url: '/api/v1/template_items/status/:name'
      method: 'PUT'

    all:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.items || []

]
