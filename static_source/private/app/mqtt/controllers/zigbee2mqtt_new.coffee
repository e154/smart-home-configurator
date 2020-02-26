angular
.module('appControllers')
.controller 'zigbee2mqttNewCtrl', ['$scope', 'Notify', 'Zigbee2mqtt', '$state', 'Message'
($scope, Notify, Zigbee2mqtt, $state, Message) ->
  vm = this

  $scope.br = new Zigbee2mqtt({
    name: 'zigbee2mqtt'
    base_topic: 'zigbee2mqtt'
  })

  $scope.submit =->
    success =(data)->
      $state.go("dashboard.mqtt.zigbee2mqtt_show", {id: data.id})

    error =(result)->
      Message result.data.status, result.data.message

    $scope.br.$create(success, error)

  vm
]
