angular
.module('appControllers')
.controller 'metricCtrl', ['$scope', 'Notify', 'Metric', 'Stream', '$log'
($scope, Notify, Metric, Stream, $log) ->

  # charts
  $scope.colors = [ '#803690', '#00ADF9', '#DCDCDC', '#46BFBD', '#FDB45C', '#949FB1', '#4D5360']
  $scope.series = []
  $scope.labels = []
  $scope.data = []

  $scope.metric = {}

  $scope.$watch 'metric.type', (t)->
    return if !t || t == ''
    switch t
      when "line"
        $scope.series = ['Series A', 'Series B']
        $scope.labels = ["January", "February", "March", "April", "May", "June", "July"]
        $scope.data = [
          [65, 59, 80, 81, 56, 55, 40],
          [28, 48, 40, 19, 86, 27, 90]
        ]
      when "bar"
        $scope.labels = ['2006', '2007', '2008', '2009', '2010', '2011', '2012']
        $scope.series = ['Series A', 'Series B']
        $scope.data = [
          [65, 59, 80, 81, 56, 55, 40],
          [28, 48, 40, 19, 86, 27, 90]
        ]
      when "doughnut"
        $scope.labels = ["Download Sales", "In-Store Sales", "Mail-Order Sales"]
        $scope.data = [300, 500, 100]
      when "radar"
        $scope.labels =["Eating", "Drinking", "Sleeping", "Designing", "Coding", "Cycling", "Running"]
        $scope.data = [
          [65, 59, 90, 81, 56, 55, 40],
          [28, 48, 40, 19, 96, 27, 100]
        ]
      when "pie"
        $scope.labels = ["Download Sales", "In-Store Sales", "Mail-Order Sales"]
        $scope.data = [300, 500, 100]
      when "horizontal bar"
        $scope.labels = ['2006', '2007', '2008', '2009', '2010', '2011', '2012']
        $scope.series = ['Series A', 'Series B']
        $scope.data = [
          [65, 59, 80, 81, 56, 55, 40],
          [28, 48, 40, 19, 86, 27, 90]
        ]

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
