angular
.module('appDirectives')
.directive 'dashboardWidgetAppMemory', ['$compile', '$templateCache'
($compile, $templateCache) ->
  restrict: 'A'
  replace: true
  scope:
    widget: '=dashboardWidgetAppMemory'
  templateUrl: '/core/templates/_widget_app_memory.html'
  link: ($scope, $element, $attrs) ->

    $scope.total_alloc = 0
    $scope.heap_alloc = 0
    $scope.alloc = 0
    $scope.sys = 0

    $scope.$on 'telemetry_update', (e, data)->
      return if !data.app_memory
      $scope.total_alloc = data.app_memory?.total_alloc || data.app_memory?.total_alloc || 0
      $scope.heap_alloc = data.app_memory?.heap_alloc || data.app_memory?.heap_alloc || 0
      $scope.alloc = data.app_memory?.alloc || data.app_memory?.alloc || 0
      $scope.sys = data.app_memory?.sys || data.app_memory?.sys || 0

    $scope.openSettings =()->
      console.log 'open settings', widget

    $scope.removeWidget =()->
      console.log 'remove widget', widget

    return
]
