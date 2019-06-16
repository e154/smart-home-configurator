angular
.module('appControllers')
.controller 'deviceShowCtrl', ['$scope', 'Notify', 'Device', '$stateParams', '$state'
($scope, Notify, Device, $stateParams, $state) ->
  vm = this

  $scope.device = {}
  success = (device) ->
    $scope.device = device

  error = ->
    $state.go 'dashboard.device.index'

  Device.show {id: $stateParams.id}, success, error


  vm
]