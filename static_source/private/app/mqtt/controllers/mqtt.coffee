angular
  .module('appControllers')
  .controller 'mqttCtrl', ['$scope', 'Notify', 'Node', 'Stream', '$log'
  ($scope, Notify, Node, Stream, $log) ->
    vm = this


    vm
]