angular
.module('appControllers')
.controller 'metricNewCtrl', ['$scope', 'Notify', 'Metric', '$state', 'Message'
($scope, Notify, Metric, $state, Message) ->

  $scope.metric = new Metric({
    name: 'New metric'
    description: ""
    type: "line"
    options:
      items: []
  })

  $scope.submit =->
    success =(data)->
      $state.go("dashboard.metric.show", {id: data.id})

    error =(result)->
      Message result.data.status, result.data.message

    $scope.metric.$create(success, error)

]
