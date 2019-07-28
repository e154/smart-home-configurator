angular
.module('angular-map')
.directive 'mapViewerDevice', ['$timeout', 'Notify', 'Stream'
($timeout, Notify, Stream) ->
  restrict: 'A'
  replace: true
  templateUrl: '/map-viewer/templates/map_viewer_device.html'
  scope:
    element: '=mapViewerDevice'
    opt: '@'
  link: ($scope, $element, $attrs) ->

    # device options
    base_options =
      show_state_text: true
      show_options_text: true
    $scope.opt = {} if !$scope.opt
    $scope.options = angular.extend $scope.opt, base_options

    $scope.current_status = null

    # vars
    # --------------------
#    console.log 'element',$scope.element
    timer = null
    $scope.show_menu = false
    $scope.element.prototype.current_state = null
    st = $scope.element.graph_settings
    $element.css
      width: st.width || 'auto'
      height: st.height || 'auto'

    # stream
    # --------------------
    setState =(_state)->
      return if !_state || !_state?.id
      for map_element_state in $scope.element.prototype.states
        if map_element_state.device_state.id == _state.id
          # update element state
          $timeout ()->
            $scope.$apply(
              $scope.element.prototype.current_state = map_element_state
            )
          break

    $scope.$on 'broadcast_device_state', (e, data)->
      return if !data || !data?.status
      if $scope.element.prototype.device.id == data.id && $scope.element.name == data.element_name
        $scope.current_status = data
        setState data.status

    $scope.doAction =(action, $event)->
      Stream.sendRequest("do.action", {action_id: action.device_action.id, device_id: $scope.element.prototype.device.id}).then (result)->
        if !result.error
          Notify 'success', "Command executed successfully", 3
        else
          Notify 'error', result.error, 3

    # menu
    # --------------------
    $scope.mouseLive =->
      return if !$scope.show_menu
      timer = $timeout ()->
        $scope.show_menu = false
        timer = null
      , 2000

    $scope.mouseOver =->
      return if timer == null
      $timeout.cancel(timer)

    $scope.showMenu =->
      $scope.show_menu = !$scope.show_menu
      timer = null if !$scope.show_menu

    # etc
    # --------------------

    return
]