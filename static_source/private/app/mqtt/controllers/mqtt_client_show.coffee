angular
.module('appControllers')
.controller 'mqttClientShowCtrl', ['$scope', 'Notify', 'MqttClient', '$stateParams', '$state', 'MqttClientSubscriptions', '$filter', 'ifCan'
($scope, Notify, MqttClient, $stateParams, $state, MqttClientSubscriptions, $filter, ifCan) ->
  vm = this

  tableCallback = {}
  unsubscribe =(clientId, topic)->
    success = (client) ->
      tableCallback.update()
    error = ->
      $state.go 'dashboard.mqtt.index'
    MqttClient.unsubscribe {id: clientId, topic: topic}, success, error

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

  vm.SubscriptionsOptions =
    perPage: 20
    resource: MqttClientSubscriptions($stateParams.id)
    columns: [
      {
        name: 'mqtt.topic.qos'
        field: 'qos'
        width: '180px'
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
    menu:
      column: 0
      buttons: [
        {
          name: $filter('translate')('mqtt.menu.unsubscribe')
          showIf: ()->
            ifCan.check({mqtt: ['close_topic']})
          clickCallback: ($event, item)->
            $event.preventDefault()
            unsubscribe($stateParams.id, item.name)
            false
        }
      ]
    callback: tableCallback
    onLoad: (result)->

  getClient()
  getSession()

  vm
]