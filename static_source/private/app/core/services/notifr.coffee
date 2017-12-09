angular
.module('appServices')
.factory 'Notifr', ['$resource', ($resource) ->
  $resource '/api/v1/notifr/:id', {id: '@id'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.item || data  

    repeat:
      url: '/api/v1/notifr/:id/repeat'
      method: 'POST'
      responseType: 'json'

    send:
      method: 'POST'
      responseType: 'json'

    update:
      method: 'PUT'

    delete:
      method: 'DELETE'

    all:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.notifications || []

]
