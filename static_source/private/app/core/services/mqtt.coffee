angular
.module('appServices')
.factory 'Mqtt', ['$resource', ($resource) ->
  $resource '/api/v1/mqtt/clients', {},
    publish:
      url: '/api/v1/mqtt/publish'
      method: 'POST'
      responseType: 'json'
]
