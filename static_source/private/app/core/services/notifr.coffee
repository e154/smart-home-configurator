angular
.module('appServices')
.factory 'Notifr', ['$resource', ($resource) ->
  $resource '/api/v1/notifr/:id', {id: '@id'},
    get_config:
      url: '/api/v1/notifr/config'
      method: 'GET'
      responseType: 'json'

    update_config:
      url: '/api/v1/notifr/config'
      method: 'PUT'

]
