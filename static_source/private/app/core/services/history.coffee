angular
.module('appServices')
.factory 'HistoryResource', ['$resource', ($resource) ->
  (mapId) ->
    $resource '/api/v1/history/', {map_id: mapId},
      all:
        url: '/api/v1/history/map'
        method: 'GET'
        responseType: 'json'
        transformResponse: (data) ->
          meta: data?.meta || {}
          items: data?.items || []

]
