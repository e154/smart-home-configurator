###*
# Created by delta54 on 23.03.17.
###

angular
.module('appControllers')
.controller 'ScriptEditorCtrl', ['$scope','Notify','$log','Stream','$rootScope','$http','Script',
'Message','$timeout', 'ScriptSelect2', '$translate'
  ($scope, Notify, $log, Stream, $rootScope, $http, Script, Message, $timeout, ScriptSelect2, $translate) ->

    $scope.ace_options = angular.copy $rootScope.ace_options
    $scope.ace_options.mode = 'coffee'
    $scope.current_script = {}
    $scope.current_script = $scope.ngModel[0] if $scope.ngModel && $scope.ngModel.length
    $scope.attached_script =
      script: null
    $scope.script_changed = false

    $scope.$watch 'ngModel', (nv, ov) ->
      return if nv == ov
      $scope.used_scripts = []
      $scope.used_scripts = nv if nv
      $scope.current_script = {}
      $scope.current_script = $scope.ngModel[0] if $scope.ngModel && $scope.ngModel.length
      $scope.used_scripts_back = angular.copy($scope.used_scripts)

    # check and mark as modified
    $scope.$watch 'used_scripts', (nv, ov) ->
      return if nv == ov
      $scope.script_changed = false
      for key, script of nv
        for key_b, script_back of $scope.used_scripts_back
          if script_back.id == script.id
            if angular.toJson(script_back) != angular.toJson(script)
              $scope.script_changed = true
              script.modif = true
    , true

    $scope.state = 'redactor' #redactor|add|new|edit
    $scope.used_scripts = $scope.ngModel || []
    $scope.used_scripts_back = angular.copy($scope.used_scripts)
    $scope.wait = 0

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
      $translate("Delete this item").then (text)->
        return if !confirm text
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
      $scope.result = ''

    appendScript =(_script)->
      exist = false
      angular.forEach $scope.used_scripts, (script) ->
        if script.id == _script.id
          exist = true

      $scope.used_scripts.push _script if !exist

    $scope.appendScript =->
      return if !$scope.attached_script.script
      appendScript($scope.attached_script.script)


    $scope.updateScript =(script, cb, err)->
      return if !script

      error =(result)->
        Message result.data.status, result.data.message
        err()

      if script.id
        success =->
          cb()
          Notify 'success', 'The script was successfully updated', 3
        Script.update script, success, error
      else
        success =(script)->
          cb()
          Notify 'success', 'The script was successfully created', 3
          script = script
          appendScript(script)
          $scope.state = 'edit'
        Script.create script, success, error

    # save all changed files
    $scope.save =->
      $scope.wait = 0
      for key, script of $scope.used_scripts
        for key_b, script_back of $scope.used_scripts_back
          if script_back.id == script.id
            if angular.toJson(script_back) != angular.toJson(script)
              $scope.wait++

              ((index, script)->
                  success =->
                    $scope.wait--
                    script.modif = false
                    if $scope.wait == 0
                      $scope.script_changed = false
                    $scope.used_scripts_back[index] = angular.copy(script)
                  error =->
                    $scope.wait--
                  $scope.updateScript(script, success, error)
              )(key_b, script)


    $scope.dialog =(state)->
      $scope.state = state
      if state == 'new'
        $scope.current_script =
          name: "New script"
          lang: "coffeescript"
          description: ""
          source: ""

    $scope.exec =->
      return if !$scope.current_script

      success =(data)->
        $scope.result = data.result

      error =(result)->
        Message result.data.status, result.data.message

      Script.exec $scope.current_script, success, error

]
