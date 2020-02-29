angular
.module('appControllers')
.controller 'zigbee2mqttEditCtrl', ['$scope', 'Message', '$stateParams', 'Zigbee2mqtt', '$state', '$translate'
($scope, Message, $stateParams, Zigbee2mqtt, $state, $translate) ->
  vm = this

  Zigbee2mqtt.show {id: $stateParams.id}, (data)->
    $scope.br = data.model
    $scope.br.password = ''
    $scope.br.password_repeat = ''

  $scope.remove =->
    $translate('Delete this item').then (text)->
      if confirm text
        remove()

  remove =->
    success =->
      $state.go("dashboard.mqtt.zigbee2mqtt")
    error =(result)->
      Message result.data.status, result.data.message
    Zigbee2mqtt.delete $scope.br, success, error

  $scope.submit =->
    success =(data)->
      $state.go("dashboard.mqtt.zigbee2mqtt_show", {id: data.id})

    error =(result)->
      Message result.data.status, result.data.message

    Zigbee2mqtt.update $scope.br, success, error

  vm
]
