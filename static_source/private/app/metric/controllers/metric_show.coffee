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
    $scope.data = []
    $scope.labels = []

    dataItems = {}

    angular.forEach $scope.metric.options.items, (item)->
      dataItems[item.name] =
        data: []
        color: item.color
        translate: item.translate

    readableDateTime = $filter('readableDateTime')

    angular.forEach $scope.metric.data, (item)->
      angular.forEach item.value, (value, name)->
        #console.log value, name
        dataItems[name].data.push value
      $scope.labels.push readableDateTime(item.time)

    angular.forEach dataItems, (value, key)->
      #console.log value, key
      $scope.data.push value.data
      $scope.colors.push value.color
      $scope.series.push value.translate

  getMetric =(id, range)->
    success = (metric) ->
      prepareMetric metric
    error = ->
      $state.go 'dashboard.metric.index'
    Metric.show {id: id, range: range}, success, error

  $scope.selectRange =(range)->
    $scope.range = range
    getMetric($stateParams.id, range)

  getMetric($stateParams.id, $scope.range)
]
