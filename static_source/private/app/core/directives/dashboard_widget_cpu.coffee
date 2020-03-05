angular
.module('appDirectives')
.directive 'dashboardWidgetCpu', ['$compile', '$templateCache'
($compile, $templateCache) ->
  restrict: 'A'
  replace: true
  scope:
    widget: '=dashboardWidgetCpu'
  templateUrl: '/core/templates/_widget_cpu_dig.html'
  link: ($scope, $element, $attrs) ->

    $scope.processors = {}
    $scope.usage = 0
    $scope.max = 0
    $scope.mhz = 0

    $scope.$on 'telemetry_update', (e, data)->
      return if !data.cpu
      $scope.usage = (data.cpu?.all || 0).toFixed(2)
      $scope.max = $scope.usage if $scope.usage > $scope.max
      $scope.mhz = data.cpu.mhz.toFixed(0)
      $scope.cores = data.cpu.cores
      $scope.model = data.cpu.model

    $scope.openSettings =()->
      console.log 'open settings', widget

    $scope.removeWidget =()->
      console.log 'remove widget', widget

    return
]
