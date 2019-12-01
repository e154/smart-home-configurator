angular
  .module('appControllers')
  .controller 'dashboardMenuCtrl', ['$scope', 'Notify', 'Stream', '$log'
  ($scope, Notify, Stream, $log) ->
    vm = this
    # gridster
    # --------------------
    $scope.gridsterOptions =
      columns: 5,
      resizable:
        enabled: false

    vm
]