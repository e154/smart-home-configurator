angular
.module('appControllers')
.controller 'accountCtrl', ['$scope', 'Notify', 'Stream'
($scope, Notify, Stream) ->
  $scope.user = app.current_user
#  $scope.user.history = angular.fromJson $scope.user.history

]