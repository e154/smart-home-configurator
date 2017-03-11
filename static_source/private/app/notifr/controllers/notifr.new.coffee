angular
.module('appControllers')
.controller 'notifrNewCtrl', ['$scope', 'Notifr','Message','$state'
($scope, Notifr, Message, $state) ->

  $scope.message = {}

  $scope.send =->
    success =->
      $scope.$parent.update()
      $scope.closeThisDialog()
    error =(result)->
      Message result.data.status, result.data.message
    Notifr.post $scope.message, success, error
]
