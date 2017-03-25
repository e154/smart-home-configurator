###*
# Created by delta54 on 23.03.17.
###

angular
.module('appControllers')
.controller 'ScriptEditorCtrl', ['$scope','Notify','$log','Stream','$rootScope','$http','Script','Message','$timeout'
  ($scope, Notify, $log, Stream, $rootScope, $http, Script, Message, $timeout) ->

    $scope.ace_options = angular.copy $rootScope.ace_options
    $scope.ace_options.mode = 'coffee'
    $scope.used_scripts = $scope.ngModel || []
    $scope.current_script = {}
    $scope.current_script = $scope.ngModel[0] if $scope.ngModel && $scope.ngModel.length
    $scope.attached_script =
      script: null

    $scope.$watch 'ngModel', (nv, ov) ->
      return if nv == ov
      $scope.used_scripts = []
      $scope.used_scripts = nv if nv
      $scope.current_script = {}
      $scope.current_script = $scope.ngModel[0] if $scope.ngModel && $scope.ngModel.length

    $scope.state = 'redactor' #redactor|add|new|edit

    # select2
    # ------------------
    $scope.scripts = []
    $scope.refreshScripts = (query)->
      $http(
        method: 'GET'
        url: window.app_settings.server_url + "/api/v1/script/search"
        params:
          query: query
          limit: 5
          offset: 0
      ).then (response)->
        $scope.scripts = response.data.scripts

    $scope.edit =(script, e)->
      e.preventDefault()
      $scope.state = 'edit'
      $scope.current_script = script
      $timeout ()->
        $scope.$apply()

    $scope.remove =(script, e)->
      e.preventDefault()
      return if !confirm("Удалить данный элемент?")

      index = $scope.used_scripts.indexOf(script)
      $scope.current_script = null if $scope.current_script == script
      $scope.used_scripts.splice(index, 1)

    $scope.select =(script, e)->
      e.preventDefault()
      switch script.lang
        when 'javascript'
          $scope.ace_options.mode = 'javascript'
        when 'coffeescript'
          $scope.ace_options.mode = 'coffee'
        when 'lua'
          $scope.ace_options.mode = 'lua'
      $scope.current_script = script

    $scope.appendScript =->
      return if !$scope.attached_script.script

      exist = false
      angular.forEach $scope.used_scripts, (script) ->
        exist = script == $scope.attached_script.script
        return if exist

      $scope.used_scripts.push $scope.attached_script.script if !exist

    $scope.updateScript =->
      return if !$scope.current_script
      success =->
        Notify.success 'Скрипт успешно обновлён', 3000
      error =(result)->
        Message result.data.status, result.data.message
      Script.update $scope.current_script, success, error
]
