angular
.module('appControllers')
.controller 'deviceNewCtrl', ['$scope', 'Notify', 'Device', '$state', 'Message', 'Node', '$translate',
  'NodeSelect2', 'DeviceSelect2', 'DeviceTypes', 'Zigbee2mqttSelect2'
($scope, Notify, Device, $state, Message, Node, $translate, NodeSelect2, DeviceSelect2, DeviceTypes,
  Zigbee2mqttSelect2) ->
  vm = this

  $scope.devices = []
  $scope.nodes = []
  $scope.zigbee2mqttDevices = []
  vm.deviceTypes = DeviceTypes

  $scope.refreshNodes = NodeSelect2 (nodes)-> $scope.nodes = nodes
  $scope.refreshDevices = DeviceSelect2 (devices)-> $scope.devices = devices
  $scope.refresZigbee2mqtt = Zigbee2mqttSelect2 (devices)-> $scope.zigbee2mqttDevices = devices

  vm.device = new Device({
    name: "New device"
    description: ""
    device: null
    node_id: null
    status: "enabled"
    type: "modbus_rtu"
    properties:
      baud: 9600
      timeout: 1000
      stop_bits: 2
  })

  vm.submit =->
    success =(data)->
      $state.go("dashboard.device.show", {id: data.id})

    error =(result)->
      Message result.data.status, result.data.message

    vm.device.$create(success, error)

  vm.getNodeInfo =->
    if !vm.device.device?.node?.id
      return

    Node.show {id: vm.device.device.node.id}, (node)->
      vm.device.device.node = node


  vm.changeDeviceType =->

  vm
]
