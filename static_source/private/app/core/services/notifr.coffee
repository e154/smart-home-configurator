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

    repeat:
      url: '/api/v1/notifr/:id/repeat'
      method: 'POST'
      responseType: 'json'

    delete:
      method: 'DELETE'

    all:
      url: '/api/v1/notifrs'
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.items || []
]
