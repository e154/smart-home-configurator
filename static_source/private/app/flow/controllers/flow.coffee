angular
.module('appControllers')
.controller 'flowCtrl', ['$scope', 'Notify', 'Flow', 'Stream', 'ngDialog'
($scope, Notify, Flow, Stream, ngDialog) ->
  vm = this

  $scope.flows = []
  $scope.getStatus = ->
    Stream.sendRequest("get.flows.status", {})

  #------------------------------------------------------------------------------
  #
  #------------------------------------------------------------------------------
  $scope.showMqttPublishDialog =(e)->
    e.preventDefault()
    ngDialog.open
      template: '/flow/templates/mqtt_publish.html'
      controller: 'MqttPublishCtrl'
      className: 'ngdialog-theme-default'
      scope: @scope
      plain: false
      overlay: true
      showClose: false
      closeByDocument: true
      closeByEscape: true

  vm
]