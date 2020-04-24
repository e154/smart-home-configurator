angular
.module('appControllers')
.controller 'metricEditCtrl', ['$scope', 'Message', '$stateParams', 'Metric', '$state', '$translate'
($scope, Message, $stateParams, Metric, $state, $translate) ->

  Metric.show {id: $stateParams.id}, (metric)->
    $scope.$parent.metric = metric

  $scope.remove =->
    success =->
      $state.go("dashboard.metric.index")
    error =(result)->
      Message result.data.status, result.data.message
    $scope.$parent.metric.$delete success, error

  $scope.submit =->
    success =(data)->
      $state.go("dashboard.metric.show", {id: $stateParams.id})

    error =(result)->
      Message result.data.status, result.data.message

    $scope.$parent.metric.$update(success, error)
]
