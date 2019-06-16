angular
.module('appControllers')
.controller 'deviceStatusCtrl', ['$scope', 'DeviceState', 'Message', '$stateParams', '$translate', 'Device'
($scope, DeviceState, Message, $stateParams, $translate, Device) ->
  vm = this

  deviceId = parseInt($stateParams.id, 10)

  vm.getAll =->

    success =(result)->
      $scope.device.states = angular.copy(result) || []

    error =(result)->
      Message result.data.status, result.data.message

    Device.statuses {id: $stateParams.id}, success, error

  vm.addNew =->
    $scope.device.states.push new DeviceState({
      system_name: "NAME"
      description: ""
      device:
        id: deviceId
    })

  vm.remove =(_state)->
    $translate('Are you sure you want to delete this state?').then (text)->
      return if !confirm text

    if _state.id
      success =()->
        statuses = angular.copy($scope.device.states)
        angular.forEach statuses, (state, key)->
          if _state.system_name == state.system_name
            statuses.splice(key, 1)
        $scope.device.states = angular.copy(statuses)

      error =(result)->
        Message result.data.status, result.data.message

      state = new DeviceState _state
      state.$delete success, error

    else
      statuses = angular.copy($scope.device.states)
      angular.forEach statuses, (state, key)->
        if _state.system_name == state.system_name
          statuses.splice(key, 1)
      $scope.device.states = angular.copy(statuses)

  vm.update =(_state)->
    success =(result)->
      angular.forEach $scope.device.states, (status, key)->
        if status.system_name == result.system_name
          $scope.device.states[key] = angular.copy result

    error =(result)->
      Message result.data.status, result.data.message

    state = new DeviceState _state
    state.device =
      id: deviceId
    state.$update success, error

  vm.create =(_state)->
    success =(result)->
      angular.forEach $scope.device.states, (status, key)->
        if status.system_name == result.system_name
          $scope.device.states[key] = angular.copy result

    error =(result)->
      Message result.data.status, result.data.message

    state = new DeviceState _state
    state.$create success, error

  vm
]