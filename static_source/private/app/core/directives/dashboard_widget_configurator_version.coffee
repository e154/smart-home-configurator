angular
.module('appDirectives')
.directive 'dashboardWidgetConfiguratorVersion', ['$compile', '$templateCache'
($compile, $templateCache) ->
  restrict: 'A'
  replace: true
  scope:
    widget: '=dashboardWidgetConfiguratorVersion'
  templateUrl: '/core/templates/_widget_service_version.html'
  link: ($scope, $element, $attrs) ->

    $scope.ver =
      version: "",
      revision: "",
      revision_url: "",
      generated: "",
      developers: "",
      build_num: "",
      docker_image: ""

    $scope.$on 'telemetry_update', (e, data)->
      return if !app?.version
      $scope.ver = angular.copy(app.version)

    $scope.openSettings =()->
      console.log 'open settings', widget

    $scope.removeWidget =()->
      console.log 'remove widget', widget

    return
]
