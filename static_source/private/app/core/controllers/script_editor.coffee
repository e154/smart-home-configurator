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
    $scope.attached_script =
      script: null
    $scope.script_changed = false
    $scope.isArray = true
    $scope.state = 'redactor' #redactor|add|new|edit
    $scope.used_scripts = $scope.ngModel || []
    $scope.used_scripts_back = angular.copy($scope.used_scripts)
    $scope.wait = 0

    init =->
      $scope.isArray = $scope.options && $scope.options.isArray || false
      $scope.current_script = null

      if $scope.isArray
        $scope.current_script = $scope.ngModel[0] if $scope.ngModel && $scope.ngModel.length
      else
        $scope.current_script = angular.copy($scope.ngModel)

    init()

    $scope.$watch 'current_script', (nv, ov) ->
      return if nv == ov

      if !$scope.current_script
        $scope.script_changed = false
        return

      if angular.toJson($scope.current_script) != angular.toJson($scope.ngModel)
        $scope.script_changed = true

      switch $scope.current_script.lang
        when 'javascript'
          $scope.ace_options.mode = 'javascript'
        when 'coffeescript'
          $scope.ace_options.mode = 'coffee'
        when 'ts'
          $scope.ace_options.mode = 'typescript'
    , true

    $scope.$watch 'ngModel', (nv, ov) ->
      return if nv == ov

      $scope.used_scripts = []
      $scope.used_scripts = nv if nv
      $scope.used_scripts_back = angular.copy($scope.used_scripts)
      init()

    # check and mark as modified
    $scope.$watch 'used_scripts', (nv, ov) ->
      return if nv == ov || !$scope.isArray
      $scope.script_changed = false
      for key, script of nv
        for key_b, script_back of $scope.used_scripts_back
          if script_back.id == script.id
            if angular.toJson(script_back) != angular.toJson(script)
              $scope.script_changed = true
              script.modif = true
    , true

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
      if !$scope.isArray
        $scope.current_script = null
        $scope.ngModel = null
        return
      return if !$scope.current_script
      $translate("Delete this item").then (text)->
        return if !confirm text
        index = $scope.used_scripts.indexOf($scope.current_script)
        $scope.used_scripts.splice(index, 1)
        $scope.current_script = null

    $scope.select =(script, e)->
      e.preventDefault() if e
      $scope.current_script = script
      $scope.result = ''

    appendScript =(_script)->
      if !$scope.isArray
        $scope.current_script = angular.copy(_script)
        $scope.ngModel = angular.copy(_script)
        return
      exist = false
      angular.forEach $scope.used_scripts, (script) ->
        if script.id == _script.id
          exist = true

      $scope.used_scripts.push _script if !exist
      $scope.used_scripts_back.push angular.copy(_script) if !exist

    $scope.appendScript =->
      return if !$scope.attached_script.script
      appendScript($scope.attached_script.script)


    $scope.updateScript =(script, cb, err)->
      return if !script

      error =(result)->
        Message result.data.status, result.data.message
        err() if err

      if script.id
        success =->
          cb() if cb
          Notify 'success', 'The script was successfully updated', 3
        Script.update script, success, error
      else
        success =(script)->
          cb() if cb
          Notify 'success', 'The script was successfully created', 3
          appendScript(script)
          $scope.state = 'edit'
        Script.create script, success, error

    # save all changed files
    $scope.save =->
      $scope.wait = 0
      if !$scope.isArray
        $scope.wait++
        success =->
          $scope.wait--
          $scope.script_changed = false
          $scope.ngModel = angular.copy($scope.current_script)
        error =->
          $scope.wait--
        $scope.updateScript($scope.current_script, success, error)
        return
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
