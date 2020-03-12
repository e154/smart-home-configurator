angular
.module('appDirectives')
.directive 'dashboardWidgetServerVersion', ['$compile', '$templateCache'
($compile, $templateCache) ->
  restrict: 'A'
  replace: true
  scope:
    widget: '=dashboardWidgetServerVersion'
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
      return if !data.server_version
      $scope.ver = data.server_version

    $scope.openSettings =()->
      console.log 'open settings', widget

    $scope.removeWidget =()->
      console.log 'remove widget', widget

    return
]
