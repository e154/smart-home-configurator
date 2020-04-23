angular
.module('appControllers')
.controller 'metricEditCtrl', ['$scope', 'Message', '$stateParams', 'Metric', '$state', '$translate'
($scope, Message, $stateParams, Metric, $state, $translate) ->

  Metric.show {id: $stateParams.id}, (metric)->
    $scope.metric = metric

  $scope.remove =->
    success =->
      $state.go("dashboard.metric.index")
    error =(result)->
      Message result.data.status, result.data.message
    $scope.metric.$delete success, error

  $scope.submit =->
    success =(data)->
      $state.go("dashboard.metric.show", {id: data.id})

    error =(result)->
      Message result.data.status, result.data.message

    $scope.metric.$update(success, error)
]
