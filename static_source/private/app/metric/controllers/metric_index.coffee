angular
.module('appControllers')
.controller 'metricIndexCtrl', ['$scope', 'Notify', 'Metric', '$state', '$timeout'
($scope, Notify, Metric, $state, $timeout) ->

  tableCallback = {}
  $scope.options =
    perPage: 20
    resource: Metric
    columns: [
      {
        name: '#'
        field: 'id'
        width: '50px'
      }
      {
        name: 'metric.name'
        field: 'name'
        clickCallback: ($event, item)->
          $event.preventDefault()
          $state.go('dashboard.metric.show', {id: item.id})
          false
      }
      {
        name: 'metric.type'
        field: 'type'
      }
      {
        name: 'metric.created_at'
        field: 'created_at'
        width: '160px'
        template: '<span>{{item[field] | readableDateTime}}</span>'
      }
      {
        name: 'metric.updated_at'
        field: 'updated_at'
        width: '160px'
        template: '<span>{{item[field] | readableDateTime}}</span>'
      }
    ]
    menu:null
    callback: tableCallback
    onLoad: (result)->
]
