angular
.module('appDirectives')
.directive 'dashboardWidgetDisk', ['$compile', '$templateCache'
($compile, $templateCache) ->
  restrict: 'A'
  replace: true
  scope:
    widget: '=dashboardWidgetDisk'
  templateUrl: '/core/templates/_widget_disk.html'
  link: ($scope, $element, $attrs) ->

    $scope.disk = null

    $scope.$on 'telemetry_update', (e, data)->
      return if !data.disk
      $scope.disk = data.disk

    $scope.openSettings =()->
      console.log 'open settings', widget

    $scope.removeWidget =()->
      console.log 'remove widget', widget

    $scope.floor = (p)->
      Math.floor(p)

    return
]