angular
.module('appControllers')
.controller 'notifrNewCtrl', ['$scope', 'Notifr','Message'
($scope, Notifr, Message) ->

  $scope.message = {}

  $scope.cancel =->
    if confirm('Вы хотите закрыть диалог?')
      $scope.closeThisDialog()

  $scope.send =->
    success =->
      $scope.$parent.update()
      $scope.closeThisDialog()
    error =(result)->
      Message result.data.status, result.data.message
    Notifr.post $scope.message, success, error
]
