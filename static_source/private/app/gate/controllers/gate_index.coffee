angular
.module('appControllers')
.controller 'gateIndexCtrl', ['$scope', 'Gate', 'ngDialog', '$q', 'Stream', '$timeout'
($scope, Gate, ngDialog, $q, Stream, $timeout) ->

  $scope.gateStatus = "wait"

  getSettings =->
    success = (settings) ->
      $scope.settings = settings
      $scope.settings.status = if settings.enabled then 'enabled' else 'disabled'

    error = ->
    Gate.getSettings {}, success, error

  getMobileList =->
    success = (list) ->
      $scope.mobileList = list
    error = ->
    Gate.getMobileList {}, success, error

  $scope.update =->
    settings = angular.copy($scope.settings)
    settings.enabled = if (settings.status == 'enabled') then true else false
    success =(data)->
    error =(result)->
    Gate.updateSettings settings, success, error

  $scope.addMobile =->
    success =()->
      getMobileList()
    error =(result)->
    Gate.addMobile {}, success, error

  $scope.show =(token)->
    defer = $q.defer()
    $scope.defer = defer
    $scope.token = token
    ngDialog.open
      template: '/gate/templates/gate_dialog.html'
      controller: 'GateDialogCtrl'
      className: 'ngdialog-theme-default ngdialog-modal-qrcode'
      scope: $scope
      plain: false
      overlay: true
      showClose: false
      closeByDocument: true
      closeByEscape: true
      preCloseCallback: ()=>
        getMobileList()
        return
    return defer.promise

  Stream.subscribe 'dashboard.telemetry', (data)->
    return if !data.gate?.status
    if data.gate.status == 'connected' && $scope.gateStatus != data.gate.status
      getMobileList()
    $scope.gateStatus = data.gate.status
    $timeout ()->
    $scope.$apply(
      $scope.gateStatus
    )

  Stream.subscribe 'gate.access_token', (data)->
    $scope.settings.gate_server_token = data.accessToken

  $scope.$on '$stateChangeSuccess', ()->
    Stream.unsubscribe 'dashboard.telemetry'
    Stream.unsubscribe 'gate.access_token'

  getSettings()
  getMobileList()


]
