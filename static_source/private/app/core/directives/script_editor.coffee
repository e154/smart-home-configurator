#
# example:
# %script-editor(ng-model="model")
# %div(script-editor="{}" ng-model="model")
#

angular
.module('appServices')
.directive 'scriptEditor', ['Script', '$compile', (Script, $compile) ->
  restrict: 'EA'
  scope:
    options: "=scriptEditor"
    ngModel: "="
  templateUrl: '/core/templates/script_editor.html'
  controller: 'ScriptEditorCtrl'
  link: ($scope, $element, $attrs) ->

]
