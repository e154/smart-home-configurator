angular
.module('appControllers')
.controller 'zigbee2mqttShowCtrl', ['$scope', 'Notify', 'Zigbee2mqtt', '$state', '$stateParams', 'ifCan'
($scope, Notify, Zigbee2mqtt, $state, $stateParams, ifCan) ->

  $scope.selected = null

  $scope.select =(obj)->
    $scope.selected = obj

  $scope.unselect =->
    $scope.selected = null

  $scope.renameDevice =->
    return if !$scope.selected
    success =->
      getBridge()
    error =(result)->
      Message result.data.status, result.data.message
    Zigbee2mqtt.device_rename {friendly_name: $scope.selected.id, name: $scope.selected.name}, {}, success, error

  $scope.updateMap =->
    return if $scope.br.scan_in_process
    $scope.br.scan_in_process = true
    success =->
      getBridge()
    error =(result)->
      Message result.data.status, result.data.message
    Zigbee2mqtt.update_networkmap {id: $stateParams.id}, {}, success, error

  getBridge =->
    success = (br) ->
      $scope.br = br
    error = ->
      $state.go 'dashboard.mqtt.zigbee2mqtt'
    Zigbee2mqtt.show {id: $stateParams.id}, success, error

  getBridge()

]
