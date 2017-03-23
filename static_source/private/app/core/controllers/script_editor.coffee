###*
# Created by delta54 on 23.03.17.
###

angular
.module('appControllers')
.controller 'ScriptEditorCtrl', ['$scope','Notify','$log','Stream','$rootScope','$http'
  ($scope, Notify, $log, Stream, $rootScope, $http) ->

    $scope.ace_options = angular.copy $rootScope.ace_options
    $scope.ace_options.mode = 'coffee'
    $scope.used_scripts = []
    $scope.current_script = {}
    $scope.attached_script =
      script: null

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

    $scope.remove =(script, e)->
      e.preventDefault()
      index = $scope.used_scripts.indexOf(script)
      $scope.current_script = null if $scope.current_script == script
      $scope.used_scripts.splice(index, 1)

    $scope.select =(script, e)->
      e.preventDefault()
      $scope.current_script = script

    $scope.appendScript =->
      return if !$scope.attached_script.script

      exist = false
      angular.forEach $scope.used_scripts, (script) ->
        exist = script == $scope.attached_script.script
        return if exist

      $scope.used_scripts.push $scope.attached_script.script if !exist

]
