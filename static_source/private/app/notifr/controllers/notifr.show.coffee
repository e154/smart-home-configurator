angular
.module('appControllers')
.controller 'notifrShowCtrl', ['$scope', 'Notifr','Message'
($scope, Notifr, Message) ->

  $scope.remove =->
    success =->
      $scope.$parent.update()
      $scope.closeThisDialog()
    error =(result)->
      Message result.data.status, result.data.message
    Notifr.delete {id: $scope.notify.id}, success, error
]
