angular
.module('appControllers')
.controller 'metricShowCtrl', ['$scope', 'Notify', 'Metric', '$stateParams', '$state', '$filter'
($scope, Notify, Metric, $stateParams, $state, $filter) ->

  $scope.colors = []
  $scope.series = []
  $scope.labels = []
  $scope.data = []

  $scope.onClick = (points, evt)->
    console.log(points, evt)

  $scope.options = {}
  $scope.range = "6h"

  prepareMetric =(metric)->
    $scope.metric = angular.copy metric
    if !$scope.metric.options?.items
      return

    $scope.colors = []
    $scope.series = []
    data = {}
    angular.forEach $scope.metric.options.items, (item)->
      $scope.colors.push item.color
      $scope.series.push item.translate
      data[item.name] = []

    readableDateTime = $filter('readableDateTime')
    $scope.labels = []
    labels = []
    angular.forEach $scope.metric.data, (item)->
      angular.forEach item.value, (value, name)->
        #console.log value, name
        data[name].push value


      labels.push readableDateTime(item.time)

    angular.forEach data, (d, n)->
      #console.log d, n
      $scope.data.push d
    $scope.labels = angular.copy labels

  getMetric =(id, range)->
    success = (metric) ->
      prepareMetric metric
    error = ->
      $state.go 'dashboard.metric.index'

    Metric.show {id: id, range: range}, success, error

  getMetric($stateParams.id, $scope.range)
]
