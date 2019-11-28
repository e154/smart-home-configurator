angular
.module('appControllers')
.controller 'mqttIndexCtrl', ['$scope', 'Notify', 'MqttClient', '$state', '$timeout'
($scope, Notify, MqttClient, $state, $timeout) ->
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
    menu:null
    callback: tableCallback
    onLoad: (result)->

  vm
]