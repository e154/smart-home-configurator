angular
.module('appControllers')
.controller 'mqttClientShowCtrl', ['$scope', 'Notify', 'MqttClient', '$stateParams', '$state', 'MqttClientSubscriptions'
($scope, Notify, MqttClient, $stateParams, $state, MqttClientSubscriptions) ->
  vm = this

  getClient =->
    success = (client) ->
      vm.client = client
    error = ->
      $state.go 'dashboard.mqtt.index'
    MqttClient.show {id: $stateParams.id}, success, error

  getSession =->
    success = (session) ->
      vm.session = session
    error = ->

    MqttClient.session {id: $stateParams.id}, success, error

  tableCallback = {}
  vm.SubscriptionsOptions =
    perPage: 20
    resource: MqttClientSubscriptions($stateParams.id)
    columns: [
      {
        name: 'mqtt.topic.qos'
        field: 'qos'
      }
      {
        name: 'mqtt.topic.name'
        field: 'name'
      }
      {
        name: 'mqtt.topic.created_at'
        field: 'at'
        template: '<span>{{item[field] | readableDateTime}}</span>'
      }
    ]
    menu:null
    callback: tableCallback
    onLoad: (result)->

  getClient()
  getSession()

  vm
]