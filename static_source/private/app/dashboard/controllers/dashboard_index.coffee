angular
.module('appControllers')
.controller 'dashboardIndexCtrl', ['$scope', 'Stream', 'Dashboard', '$timeout', 'Message'
($scope, Stream, Dashboard, $timeout, Message) ->

  angular.element(document).find('body').addClass('dashboard')
  $scope.total_uptime = 0

  # gridster
  # --------------------
  $scope.gridsterOptions =
    columns: 6,
    resizable:
      enabled: true,
      handles: ['e', 's', 'se'],
      stop: (event, $element, widget)-> {}
    draggable:
      stop: (event, $element, widget)-> {}

  # dashboard
  # --------------------
  $scope.dashboard = {}
  $scope.current_widget = null
  $scope.dashboard.widgets = [
    {id: 30, col: 0, row: 0, sizeY: 1, sizeX: 1, name: 'cpu', type: 'cpu_dig' }
    {id: 20, col: 1, row: 0, sizeY: 1, sizeX: 2, name: 'memory', type: 'memory' }
    {id: 10, col: 3, row: 0, sizeY: 1, sizeX: 2, name: 'swap', type: 'swap' }
    {id: 70, col: 0, row: 1, sizeY: 1, sizeX: 2, name: 'app_memory', type: 'app_memory' }
    {id: 90, col: 2, row: 1, sizeY: 1, sizeX: 1, name: 'workflows', type: 'workflows' }
    {id: 80, col: 3, row: 1, sizeY: 1, sizeX: 1, name: 'flows', type: 'flows' }
    {id: 60, col: 4, row: 1, sizeY: 1, sizeX: 1, name: 'disk', type: 'disk' }
    {id: 100, col: 0, row: 2, sizeY: 1, sizeX: 1, name: 'mqtt', type: 'mqtt' }
    {id: 40, col: 1, row: 2, sizeY: 1, sizeX: 1, name: 'nodes', type: 'nodes' }
    {id: 50, col: 2, row: 2, sizeY: 1, sizeX: 1, name: 'devices', type: 'devices' }
    {id: 130, col: 3, row: 2, sizeY: 1, sizeX: 2, name: 'history', type: 'history' }
    {id: 110, col: 0, row: 3, sizeY: 1, sizeX: 2, name: 'server_version', type: 'server_version' }
    {id: 120, col: 2, row: 3, sizeY: 1, sizeX: 2, name: 'configurator_version', type: 'configurator_version' }
  ]

  #TODO remove hard code
#  $scope.dashboard = new Dashboard({id:1})
#  success =(dashboard)->
#    dashboard.widgets = $scope.widgets
#  error = (result)->
#    Message result.data.status, result.data.message
#  $scope.dashboard.$show success, error

  # stream
  # --------------------
  $timeout ()->
    Stream.sendRequest("dashboard.get.telemetry", {}).then (data)->
      broadcastDeviceState(data)
  , 1000

  Stream.subscribe 'dashboard.telemetry', 'dashboard', (data)->
    $scope.total_uptime = data.uptime.total if data.uptime?.total
    $scope.$apply()
    broadcastDeviceState(data)

  broadcastDeviceState =(data)->
    $scope.$broadcast 'telemetry_update', data

  $scope.$on '$stateChangeSuccess', ()->
    Stream.unsubscribe 'dashboard.telemetry', 'dashboard'

  # crud
  # --------------------
  $scope.removeWidget =(widget)->
    console.log 'remove widget', widget

  $scope.addWidget =(widget)->
    console.log 'add widget', widget

]
