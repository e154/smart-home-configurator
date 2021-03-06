angular
.module('appServices')
.factory 'MapElementResource', ['$resource', ($resource) ->
  $resource '/api/v1/map_element/:id', {id: '@id'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.map_element || data

    create:
      method: 'POST'
      responseType: 'json'
      transformResponse: (data) ->
        data?.map_element || data

    update:
        method: 'PUT'
        responseType: 'json'

    sort:
      url: '/api/v1/map_elements/sort'
      method: 'PUT'
      responseType: 'json'

    update_element_only:
      url: '/api/v1/map_element/:id/element_only'
      method: 'PUT'
      responseType: 'json'

    delete:
      method: 'DELETE'

    all:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.map_elements || []

]
