angular
.module('appServices')
.factory 'TemplateItem', ['$resource', ($resource) ->
  $resource '/api/v1/template_item/:name', {},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.item || data  

    create:
      url: '/api/v1/template_item'
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
      isArray: true

    update_tree:
      url: '/api/v1/template_items/tree'
      method: 'PUT'

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
