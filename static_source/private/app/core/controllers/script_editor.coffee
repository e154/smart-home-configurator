###*
# Created by delta54 on 23.03.17.
###

angular
.module('appControllers')
.controller 'ScriptEditorCtrl', ['$scope','Notify','$log','Stream','$rootScope','$http','Script','Message','$timeout', 'ScriptSelect2'
  ($scope, Notify, $log, Stream, $rootScope, $http, Script, Message, $timeout, ScriptSelect2) ->

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
    $scope.refreshScripts = ScriptSelect2 (scripts)-> $scope.scripts = scripts

    $scope.edit =(e)->
      e.preventDefault()
      return if !$scope.current_script
      $scope.state = 'edit'
      $timeout ()->
        $scope.$apply()

    $scope.remove_from_filelist =(e)->
      e.preventDefault()
      return if !$scope.current_script
      return if !confirm("Удалить данный элемент?")

      index = $scope.used_scripts.indexOf($scope.current_script)
      $scope.used_scripts.splice(index, 1)
      $scope.current_script = null

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

    appendScript =(_script)->
      exist = false
      angular.forEach $scope.used_scripts, (script) ->
        if script.id == _script.id
          exist = true

      $scope.used_scripts.push _script if !exist

    $scope.appendScript =->
      return if !$scope.attached_script.script
      appendScript($scope.attached_script.script)


    $scope.updateScript =->
      return if !$scope.current_script
      error =(result)->
        Message result.data.status, result.data.message

      if $scope.current_script.id
        success =->
          Notify 'success', 'Скрипт успешно обновлён', 3
        Script.update $scope.current_script, success, error
      else
        success =(script)->
          Notify 'success', 'Скрипт успешно создан', 3
          $scope.current_script = script
          appendScript($scope.current_script)
          $scope.state = 'edit'
        Script.create $scope.current_script, success, error

    $scope.dialog =(state)->
      $scope.state = state
      if state == 'new'
        $scope.current_script =
          name: "Новый скрипт"
          lang: "coffeescript"
          description: ""
          source: ""

]
