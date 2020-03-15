angular
.module('appDirectives')
.directive 'dashboardWidgetHistory', ['$compile', '$templateCache'
($compile, $templateCache) ->
  restrict: 'A'
  replace: true
  scope:
    widget: '=dashboardWidgetHistory'
  templateUrl: '/core/templates/_widget_history.html'
  link: ($scope, $element, $attrs) ->

    $scope.history = []

    $scope.$on 'telemetry_update', (e, data)->
      return if !data?.history?.items
      $scope.history = angular.copy(data.history.items)

    $scope.openSettings =()->
      console.log 'open settings', widget

    $scope.removeWidget =()->
      console.log 'remove widget', widget

    return
]
