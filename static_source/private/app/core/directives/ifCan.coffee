#
# directive:
# if-can="{map: ['read', 'update'], node: ['read', 'update']}"
#
# url:
# https://stackoverflow.com/questions/20325480/angularjs-whats-the-best-practice-to-add-ngif-to-a-directive-programmatically
#

NAME = 'ifCan'
angular
.module('appDirectives')
.directive NAME, ['ngIfDirective' ,'ifCan'
(ngIfDirective, ifCan) ->
  ngIf = ngIfDirective[0]
  {
    transclude: ngIf.transclude
    priority: ngIf.priority
    terminal: ngIf.terminal
    restrict: ngIf.restrict
    scope:
      params: '=ifCan'
    link: ($scope, $element, $attr) ->
      $attr.ngIf = ->
        ifCan.check($scope.params)

      ngIf.link.apply ngIf, arguments
      return

  }
]
