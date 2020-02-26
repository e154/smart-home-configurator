angular
.module('appControllers')
.controller 'zigbee2mqttShowCtrl', ['$scope', 'Notify', 'Zigbee2mqtt', '$state', '$stateParams', 'ifCan'
($scope, Notify, Zigbee2mqtt, $state, $stateParams, ifCan) ->

  getBridge =->
    success = (br) ->
      $scope.br = br
    error = ->
      $state.go 'dashboard.mqtt.zigbee2mqtt'
    Zigbee2mqtt.show {id: $stateParams.id}, success, error

  getBridge()

]
