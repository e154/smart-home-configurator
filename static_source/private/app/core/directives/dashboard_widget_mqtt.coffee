angular
.module('appDirectives')
.directive 'dashboardWidgetMqtt', ['$compile', '$templateCache'
($compile, $templateCache) ->
  restrict: 'A'
  replace: true
  scope:
    widget: '=dashboardWidgetMqtt'
  templateUrl: '/core/templates/_widget_mqtt.html'
  link: ($scope, $element, $attrs) ->

    $scope.client_state = {
      connected_total: 0
      disconnected_total: 0
      active_current: 0
      inactive_current: 0
      expired_total: 0
    }

    $scope.$on 'telemetry_update', (e, data)->
      return if !data?.mqtt
      if data?.mqtt?.client_state
        $scope.client_state = data.mqtt.client_state

    $scope.openSettings =()->
      console.log 'open settings', widget

    $scope.removeWidget =()->
      console.log 'remove widget', widget

    return
]
