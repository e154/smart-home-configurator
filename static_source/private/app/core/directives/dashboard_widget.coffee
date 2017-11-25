angular
.module('appDirectives')
.directive 'dashboardWidget', ['$compile', '$templateCache'
($compile, $templateCache) ->
  restrict: 'A'
  replace: true
  scope:
    widget: '=dashboardWidget'
  templateUrl: '/core/templates/_widget.html'
  link: ($scope, $element, $attrs) ->

    return
]