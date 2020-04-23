angular
.module('appControllers')
.controller 'metricCtrl', ['$scope', 'Notify', 'Metric', 'Stream', '$log'
($scope, Notify, Metric, Stream, $log) ->

  $scope.metric = {}

  $scope.addNewOptionItem =->
    if !$scope.metric?.options
      $scope.metric.options =
        items: []

    if !$scope.metric.options?.items
      $scope.metric.options.items = []

    $scope.metric.options.items.push {
      "name": "temperature",
      "translate": "Temperature",
      "description": "Temperature",
      "color": "#0000ff",
      "label": "C°"
    }

  $scope.removeOptionItem =($event, item)->
    $event.preventDefault()
    index = $scope.metric.options.items.indexOf(item)
    $scope.metric.options.items.splice(index, 1)

]
