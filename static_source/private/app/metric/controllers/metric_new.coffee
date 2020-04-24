angular
.module('appControllers')
.controller 'metricNewCtrl', ['$scope', 'Notify', 'Metric', '$state', 'Message'
($scope, Notify, Metric, $state, Message) ->

  $scope.$parent.metric = new Metric({
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

    $scope.$parent.metric.$create(success, error)

  $scope.removeOptionItem =($event, item)->
    $event.preventDefault()
    index = $scope.$parent.metric.options.items.indexOf(item)
    $scope.$parent.metric.options.items.splice(index, 1)

  $scope.addNewOptionItem =->
    if !$scope.$parent.metric?.options
      $scope.$parent.metric.options =
        items: []

    if !$scope.$parent.metric.options?.items
      $scope.$parent.metric.options.items = []

    $scope.$parent.metric.options.items.push {
      "name": "temperature",
      "translate": "Temperature",
      "description": "Temperature",
      "color": "#0000ff",
      "label": "C°"
    }

]
