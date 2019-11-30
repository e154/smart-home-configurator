angular
.module('appControllers')
.controller 'mqttIndexCtrl', ['$scope', 'Notify', 'MqttClient', '$state', '$filter', 'ifCan'
($scope, Notify, MqttClient, $state, $filter, ifCan) ->
  vm = this

  tableCallback = {}
  vm.options =
    perPage: 20
    resource: MqttClient
    columns: [
      {
        name: '#'
        field: 'client_id'
        clickCallback: ($event, item)->
          $event.preventDefault()
          $state.go('dashboard.mqtt.client_show', {id: item.client_id})

          false
      }
      {
        name: 'mqtt.connected_at'
        field: 'connected_at'
        template: '<span>{{item[field] | readableDateTime}}</span>'
      }
      {
        name: 'mqtt.disconnected_at'
        field: 'disconnected_at'
        template: '<span>{{item[field] | readableDateTime}}</span>'
      }
    ]
    menu:
      column: 0
      buttons: [
        {
          name: $filter('translate')('mqtt.menu.close')
          showIf: ()->
            ifCan.check({mqtt: ['close_client']})
          clickCallback: ($event, item)->
            $event.preventDefault()
            clientClose(item.client_id)
            false
        }
      ]
    callback: tableCallback
    onLoad: (result)->

  clientClose =(clienId)->
    success = (client) ->
      tableCallback.update()
      return
    error = ->
      $state.go 'dashboard.mqtt.index'
    MqttClient.close {id: clienId}, success, error

  vm
]