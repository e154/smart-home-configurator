angular
.module('appServices')
.factory 'MapResource', ['$resource', ($resource) ->
  $resource '/api/v1/map/:id', {id: '@id'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.map || data

    create:
      method: 'POST'
      responseType: 'json'
      transformResponse: (data) ->
        data?.map || data

    update:
        method: 'PUT'
        responseType: 'json'
        transformRequest: (data)->
          data.options = angular.toJson(data.options)
          result = angular.toJson(data);
          result

    delete:
      method: 'DELETE'

    all:
      url: '/api/v1/maps'
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.items || []

    showFull:
      url: '/api/v1/map/:id/full'
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        map = data?.map || data
        map.options = angular.fromJson(map.options || "{}") || {}
        map
]
