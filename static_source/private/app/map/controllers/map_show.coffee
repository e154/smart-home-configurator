angular
.module('appControllers')
.controller 'mapShowCtrl', ['$scope', '$state', 'Message', '$stateParams', 'MapResource', 'Notify', 'HistoryResource'
'Stream', '$timeout'
($scope, $state, Message, $stateParams, MapResource, Notify, HistoryResource, Stream, $timeout) ->

  $scope.map = new MapResource {id: $stateParams.id}
  $scope.options = {}

  $scope.levels = [
    {
      name: 'Emergency'
      value: 'Emergency'
      selected: false
    }
    {
      name: 'Alert'
      value: 'Alert'
      selected: false
    }
    {
      name: 'Critical'
      value: 'Critical'
      selected: false
    }
    {
      name: 'Error'
      value: 'Error'
      selected: false
    }
    {
      name: 'Warning'
      value: 'Warning'
      selected: false
    }
    {
      name: 'Notice'
      value: 'Notice'
      selected: false
    }
    {
      name: 'Info'
      value: 'Info'
      selected: false
    }
    {
      name: 'Debug'
      value: 'Debug'
      selected: false
    }
  ]

  getMap =->
    success =()=>
    error =(result)->
      Message result.data.status, result.data.message
    $scope.map.$showFull success, error


  tableCallback = {}
  $scope.options =
    perPage: 20
    resource: HistoryResource($stateParams.id)
    columns: [
      {
        name: 'type'
        field: 'type'
      }
      {
        name: 'device'
        field: 'description'
        template: '<span>{{item.map_element[field]}}</span>'
      }
      {
        name: 'description'
        field: 'description'
      }
      {
        name: 'created_at'
        field: 'created_at'
        width: '160px'
        template: '<span>{{item[field] | readableDateTime}}</span>'
      }
    ]
    menu:null
    callback: tableCallback
    onLoad: (result)->
    rows: (item)->
      style
      switch item.type
        when 'Emergency'
          style = 'log-emergency'
        when 'Alert'
          style = 'log-alert'
        when 'Critical'
          style = 'log-critical'
        when 'Error'
          style = 'log-error'
        when 'Warning'
          style = 'log-warning'
        when 'Notice'
          style = 'log-notice'
        when 'Info'
          style = 'log-info'
        when 'Debug'
          style = 'log-debug'
      style

  $timeout ()->
    Stream.subscribe 'map.telemetry', (data)->
      return if !data.device
      tableCallback.update()
  , 1000

  #------------------------------------------------------------------------------
  # init
  #------------------------------------------------------------------------------
  getMap()

  return
]
