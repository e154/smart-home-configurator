angular
.module('appControllers')
.controller 'scenarioIndexCtrl', ['$scope', 'Notify', 'Scenario', '$state'
($scope, Notify, Scenario, $state) ->

  tableCallback = {}
  $scope.options =
    perPage: 20
    resource: Scenario
    columns: [
      {
        name: '#'
        field: 'id'
      }
      {
        name: 'scenario.name'
        field: 'name'
        clickCallback: ($event, item)->
          $event.preventDefault()
          $state.go('dashboard.scenario.show', {id: item.id})
          false
      }
      {
        name: 'scenario.system_name'
        field: 'system_name'
      }
      {
        name: 'scenario.created_at'
        field: 'created_at'
        template: '<span>{{item[field] | readableDateTime}}</span>'
      }
      {
        name: 'scenario.update_at'
        field: 'update_at'
        template: '<span>{{item[field] | readableDateTime}}</span>'
      }
    ]
    menu:null
    callback: tableCallback
    onLoad: (result)->
]