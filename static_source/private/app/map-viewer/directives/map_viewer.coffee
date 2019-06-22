#
# %div(map-viewer="options" map="map")
#

angular
.module('angular-map')
.directive 'mapViewer', ['$compile', 'mapPanning', 'mapFullscreen', 'Stream', '$timeout'
($compile, mapPanning, mapFullscreen, Stream, $timeout) ->
  restrict: 'A'
  templateUrl: '/map-viewer/templates/map_viewer.html'
  scope:
    options: '=mapViewer'
    map: '='
  link: ($scope, $element, $attrs) ->

    # set default options
    # --------------------
    options = {}

    $scope.zoom = 1.0
    $scope.settings =
      movable: true
      zoom: true
      minHeight: 100
      minWidth: 400
    container = $element.find('.map-viewer')
    wrapper = $element.find('.map-wrapper')
    preventSelection(document.querySelector('.map-wrapper'))
    panning = new mapPanning(container, $scope, wrapper)
    fullscreen = new mapFullscreen(wrapper, $scope)

    $scope.devices = {}

    # stream
    # --------------------
    $timeout ()->
      Stream.sendRequest("map.get.devices.states", {}).then (data)->
        return if !data.states
        broadcastDeviceState(data.states.device_stats)
    , 1000

    Stream.subscribe 'map.telemetry', (data)->
      return if !data.device
      broadcastDeviceState([data.device])

    broadcastDeviceState =(states)->
      angular.forEach states, (state, id)->
        $scope.$broadcast 'broadcast_device_state', state

    # etc
    # --------------------
    getOptions =->
      $scope.options = {} if !$scope.options
      options = $.extend true, $scope.settings, $scope.options

    $scope.$watch 'options', (val, oldVal)->
      return if !val || val == oldVal
      getOptions()

    $scope.$watch 'map.layers', (val, oldVal)->
      return if !val
      $scope.zoom = $scope.map.options?.zoom || 1.2
      panning.setZoom($scope.zoom)
      return if !$scope.map.layers
#      angular.forEach $scope.map.layers, (layer)->
#        angular.forEach layer.elements, (element)->
#          element.graph_settings = angular.fromJson(element.graph_settings)

    #init
    getOptions()

#    console.log 'options',$scope.options
#    console.log 'map',$scope.map

    return
]