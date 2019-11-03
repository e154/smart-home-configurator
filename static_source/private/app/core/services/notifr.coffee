angular
.module('appServices')
.factory 'Notifr', ['$resource', ($resource) ->
  $resource '/api/v1/notify/:id', {id: '@id'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.item || data  

    repeat:
      url: '/api/v1/notify/:id/repeat'
      method: 'POST'
      responseType: 'json'

    get_config:
      url: '/api/v1/notify/config'
      method: 'GET'
      responseType: 'json'

    update_config:
      url: '/api/v1/notify/config'
      method: 'PUT'

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
