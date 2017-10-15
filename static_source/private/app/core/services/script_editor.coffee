#
# Script editor
#

angular
.module('appServices')
.factory 'ScriptEditor', [ '$log', 'ngDialog', '$rootScope', '$timeout', 'Notify'
($log, ngDialog, $rootScope, $timeout, Notify) ->
  class ScriptEditor
    dialog: null
    scope: null
    title: "Script editor"

    constructor: (scope)->
      @scope = scope
      @scope = $rootScope.$new() if !scope
      @scope.file_list = []

    showModal: ->
      defer = $q.defer()
      @scope.defer = defer
      @scope.options = options
      @dialog = ngDialog.open
        template: '/core/templates/script_editor.html'
        controller: 'ScriptEditorCtrl'
        className: 'ngdialog-theme-default ngdialog-modal-script-editor'
        scope: @scope
        plain: false
        overlay: true
        showClose: false
        closeByDocument: true
        closeByEscape: true
      return defer.promise

    hideModal: ->
      if @dialog
        @dialog.close()

  ScriptEditor
]
