#
# example:
# %script-editor(ng-model="model" options="{}")
# %div(script-editor ng-model="model" options="{}")
#

angular
.module('appServices')
.directive 'scriptEditor', ['Script', '$compile', (Script, $compile) ->
  restrict: 'EA'
  scope:
    options: "=options"
    ngModel: "="
  templateUrl: '/core/templates/script_editor.html'
  controller: 'ScriptEditorCtrl'
  link: ($scope, $element, $attrs) ->

]
