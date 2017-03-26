angular
.module('appControllers')
.controller 'workflowCtrl', ['$scope', 'Notify', 'Workflow', 'Stream'
($scope, Notify, Workflow, Stream) ->
  vm = this

  $scope.workflows = []
  $scope.getStatus = ->
    Stream.sendRequest("get.workflow.status", {})

  vm
]