angular
.module('appServices')
.factory 'Role', ['$resource', ($resource) ->
  $resource '/api/v1/role/:name', {name: '@name'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.role || data

    create:
      url: '/api/v1/role'
      method: 'POST'
      responseType: 'json'
      transformResponse: (data) ->
        data?.role || data

    update:
      method: 'PUT'
      responseType: 'json'

    delete:
      method: 'DELETE'

    all:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.roles || []

    get_access_list:
      url: '/api/v1/role/:name/access_list'
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.access_list || data

    update_access_list:
      url: '/api/v1/role/:name/access_list'
      method: 'PUT'
      responseType: 'json'

]
