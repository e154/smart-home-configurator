angular
.module('appDirectives')
.directive 'dashboardWidgetFlows', ['$compile', '$templateCache'
($compile, $templateCache) ->
  restrict: 'A'
  replace: true
  scope:
    widget: '=dashboardWidgetFlows'
  templateUrl: '/core/templates/_widget_flows.html'
  link: ($scope, $element, $attrs) ->

    $scope.total = 0
    $scope.online = 0
    $scope.disabled = 0
    $scope.error = 0

    $scope.$on 'telemetry_update', (e, data)->
      return if !data.flow?
      $scope.total = data.flow.total if data.flow.total
      $scope.disabled = data.flow.disabled if data.flow.disabled
      $scope.online = $scope.total - $scope.disabled

    $scope.openSettings =()->
      console.log 'open settings', widget

    $scope.removeWidget =()->
      console.log 'remove widget', widget

    return
]
