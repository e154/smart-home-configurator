angular
.module('appControllers')
.controller 'zigbee2mqttShowCtrl', ['$scope', 'Notify', 'Zigbee2mqtt', '$state', '$stateParams', 'ifCan', 'Stream'
($scope, Notify, Zigbee2mqtt, $state, $stateParams, ifCan, Stream) ->

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

  $scope.reset =->
    success =->
      getBridge()
    error =(result)->
      Message result.data.status, result.data.message
    Zigbee2mqtt.reset {id: $stateParams.id}, {}, success, error

  $scope.update_permit_join =->
    $scope.br.model.permit_join = !$scope.br.model.permit_join
    success =->
      getBridge()
    error =(result)->
      Message result.data.status, result.data.message
      $scope.br.model.password = null
      $scope.br.model.password_repeat = null
    Zigbee2mqtt.update {id: $stateParams.id}, $scope.br.model, success, error

  getBridge =->
    success = (br) ->
      $scope.br = br
    error = ->
      $state.go 'dashboard.mqtt.zigbee2mqtt'
    Zigbee2mqtt.show {id: $stateParams.id}, success, error

  Stream.subscribe 'dashboard.telemetry', 'zigbee2mqtt', (data)->
    return !data?.zigbee2mqtt
    getBridge()

  $scope.$on '$stateChangeSuccess', ()->
    Stream.unsubscribe 'dashboard.telemetry', 'zigbee2mqtt'

  getBridge()

]
