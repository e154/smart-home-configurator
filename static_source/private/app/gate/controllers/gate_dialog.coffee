###*
# Created by delta54 on 20.12.14.
###

angular
.module('appControllers')
.controller 'GateDialogCtrl', ['$scope','Gate','$log','Stream','$timeout'
  ($scope, Gate, $log, Stream, $timeout) ->

    $scope.deleteMobile =($event, item)->
      $event.preventDefault()
      success =->
        $scope.closeThisDialog()
      error =->
      Gate.deleteMobile {'token': $scope.token}, success, error


]
