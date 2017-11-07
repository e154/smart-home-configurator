angular
.module('appControllers')
.controller 'deviceActionCtrl', ['$scope', 'Notify', 'DeviceAction', 'Message', '$stateParams', 'Device'
'$http', 'ngDialog', 'Stream', '$translate'
($scope, Notify, DeviceAction, Message, $stateParams, Device, $http, ngDialog, Stream, $translate) ->
  vm = this
  vm.actions = []
  vm.current ={}
  vm.last_current =null
  vm.state = 'show' #show|add|edit|script_editor

  vm.addNew =->
    vm.state = 'add'
    vm.getDefaultAction()

  vm.show =(action)->
    vm.last_current = angular.copy action
    vm.current = new DeviceAction(action)

  $scope.$watch 'vm.current.script', (nv, ov) ->
    return if nv == ov

  vm.getDeviceActions =->
    Device.actions {id: $stateParams.id}, (actions)->
      vm.actions = actions
      if actions.length == 0
        vm.state = 'edit'
      return

  vm.getDefaultAction =->
    vm.current = new DeviceAction({
        name: "New action"
        command: "03000005"
        script: null
        description: "action description"
        device:
          id: parseInt($stateParams.id, 10)
      })

  vm.submit =->
    success =(result)->
      Notify 'success', 'Action successfully updated', 3
      vm.state = 'show'
      vm.getDeviceActions()
      vm.getDefaultAction()

    error =(result)->
      Message result.data.status, result.data.message

    if !vm.current.id
      vm.current.$create(success, error)
    else
      vm.current.$update(success, error)

  vm.cancel =->
    return if !vm.last_current
    vm.current = new DeviceAction(vm.last_current)
    vm.state = 'show'
    return

  vm.remove =->
    success =->
      vm.state = 'show'
      vm.getDeviceActions()
      vm.getDefaultAction()

    error =(result)->
      Message result.data.status, result.data.message

    $translate('Are you sure you want to delete this action?').then (text)->
      if confirm text
        vm.current.$remove(success, error)

  # select2
  # ------------------
  $scope.scripts = []
  $scope.refreshScripts = (query)->
    $http(
      method: 'GET'
      url: app.server_url + "/api/v1/script/search"
      params:
        query: query
        limit: 5
        offset: 0
    ).then (response)->
      $scope.scripts = response.data.scripts

  # scripts
  #------------------------------------------------------------------------------
  vm.showScript =(script, e)->
    e.preventDefault()
    $scope.script = script

    ngDialog.open
      scope: $scope
      showClose: false
      template: '/script/templates/modal.show.html'
      className: 'ngdialog-theme-default ngdialog-scripts-show'
      controller: 'scriptModalShowCtrl'
      controllerAs: 'script'

  vm.addScript =(e)=>
    e.preventDefault()
    $scope.setScript =(script)=>
      vm.current.script = script

    ngDialog.open
      scope: $scope
      showClose: false
      closeByEscape: false
      closeByDocument: false
      template: '/script/templates/modal.new.html'
      className: 'ngdialog-theme-default ngdialog-scripts-edit'
      controller: 'scriptModalNewCtrl'
      controllerAs: 'script'
      preCloseCallback: ()=>
        vm.getDeviceActions()
        vm.getDefaultAction()
        return

  vm.editScript =(script, e)->
    e.preventDefault()
    $scope.script = script
    $scope.setScript =(script)=>
      vm.current.script = script

    ngDialog.open
      scope: $scope
      showClose: false
      closeByEscape: false
      closeByDocument: false
      template: '/script/templates/modal.edit.html'
      className: 'ngdialog-theme-default ngdialog-scripts-edit'
      controller: 'scriptModalEditCtrl'
      controllerAs: 'script'

  vm.doAction =(action, e)->
    e.preventDefault()
    e.stopPropagation()
    return if !action.id

    Stream.sendRequest("do.action", {action_id: action.id, device_id: parseInt($stateParams.id, 10)}).then (result)->
      if !result.error
        Notify 'success', "Command executed successfully", 3
      else
        Notify 'error', result.error, 3

  # starting
  # ------------------------------------------
  vm.getDeviceActions()
  vm.getDefaultAction()

  vm
]