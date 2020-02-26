angular
.module('appServices')
.factory 'Zigbee2mqtt', ['$resource', ($resource) ->
  $resource '/api/v1/zigbee2mqtt/:id', {id: '@id'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.device || data

    create:
      method: 'POST'
      url: '/api/v1/zigbee2mqtt'
      responseType: 'json'

    reset:
      method: 'POST'
      url: '/api/v1/zigbee2mqtt/:id/reset'
      responseType: 'json'

    device_ban:
      method: 'POST'
      url: '/api/v1/zigbee2mqtt/:id/device_ban'
      responseType: 'json'

    device_whitelist:
      method: 'POST'
      url: '/api/v1/zigbee2mqtt/:id/device_whitelist'
      responseType: 'json'

    update_networkmap:
      method: 'POST'
      url: '/api/v1/zigbee2mqtt/:id/update_networkmap'
      responseType: 'json'

    networkmap:
      method: 'GET'
      url: '/api/v1/zigbee2mqtt/:id/networkmap'
      responseType: 'json'

    device_rename:
      method: 'PATCH'
      url: '/api/v1/zigbee2mqtt/:id/device_rename'
      responseType: 'json'

    update:
      method: 'PUT'
      url: '/api/v1/zigbee2mqtt/:id'
      responseType: 'json'

    delete:
      method: 'DELETE'

    all:
      url: '/api/v1/zigbee2mqtts'
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.items || []

]
