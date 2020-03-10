angular
.module('appDirectives')
.directive 'dashboardWidgetWorkflows', ['$compile', '$templateCache'
($compile, $templateCache) ->
  restrict: 'A'
  replace: true
  scope:
    widget: '=dashboardWidgetWorkflows'
  templateUrl: '/core/templates/_widget_flows.html'
  link: ($scope, $element, $attrs) ->

    $scope.total = 0
    $scope.online = 0
    $scope.disabled = 0
    $scope.error = 0

    $scope.$on 'telemetry_update', (e, data)->
      return if !data.workflows?
      $scope.total = data.workflows.total if data.workflows.total
      $scope.disabled = data.workflows.disabled if data.workflows.disabled
      $scope.online = $scope.total - $scope.disabled

    $scope.openSettings =()->
      console.log 'open settings', widget

    $scope.removeWidget =()->
      console.log 'remove widget', widget

    return
]
