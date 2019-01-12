angular
.module('appControllers')
.controller 'deviceEditCtrl', ['$scope', 'Message', '$stateParams', 'Device', '$state', 'Node'
'$translate', 'NodeSelect2', 'DeviceSelect2', 'DeviceTypes'
($scope, Message, $stateParams, Device, $state, Node, $translate, NodeSelect2, DeviceSelect2, DeviceTypes) ->
  vm = this

  $scope.devices = []
  $scope.nodes = []
  vm.deviceTypes = DeviceTypes

  $scope.refreshNodes = NodeSelect2 (nodes)-> $scope.nodes = nodes
  $scope.refreshDevices = DeviceSelect2 (devices)-> $scope.devices = devices

  Device.show {id: $stateParams.id}, (device)->
    vm.device = device

  vm.remove =->
    $translate('remove this device?').then (text)->
      if confirm text
        remove()

  remove =->
    success =->
      $state.go("dashboard.device.index")
    error =(result)->
      Message result.data.status, result.data.message
    vm.device.$delete success, error

  vm.submit =->
    success =(data)->

    error =(result)->
      Message result.data.status, result.data.message
      angular.forEach result.data.errors, (err)->
        Message result.data.status, err.field + ' - ' + err.message

    vm.device.$update(success, error)

  vm
]