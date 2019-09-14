angular
.module('appServices')
.factory 'MapZone', ['$resource', ($resource) ->
  $resource '/api/v1/map_zone', {id: '@id'},
    create:
      method: 'POST'
      responseType: 'json'
      transformResponse: (data) ->
        data?.zone || data

    delete:
      method: 'DELETE'
]
