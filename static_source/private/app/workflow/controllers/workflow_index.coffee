angular
.module('appControllers')
.controller 'workflowIndexCtrl', ['$scope', 'Notify', 'Workflow', '$state', '$timeout'
($scope, Notify, Workflow, $state, $timeout) ->
  vm = this

  tableCallback = {}
  vm.options =
    perPage: 20
    resource: Workflow
    columns: [
      {
        name: '#'
        field: 'id'
      }
      {
        name: 'workflow.name'
        field: 'name'
        clickCallback: ($event, item)->
          $event.preventDefault()
          $state.go('dashboard.workflow.show', {id: item.id})
          false
      }
      {
        name: 'workflow.scenario.scenario'
        field: 'scenario'
        template: '<span class="label label-success">{{::item[field].name}}</span>'
      }
      {
        name: 'workflow.created_at'
        field: 'created_at'
        width: '160px'
        template: '<span>{{item[field] | readableDateTime}}</span>'
      }
      {
        name: 'workflow.updated_at'
        field: 'updated_at'
        width: '160px'
        template: '<span>{{item[field] | readableDateTime}}</span>'
      }
      {
        name: 'workflow.status'
        sort: 'disable'
        width: '50px'
        template: "
<span class='label label-success' ng-if='item[\"status\"] == \"enabled\"'>{{'workflow.enabled' | translate}}</span>
<span class='label label-default' ng-if='item[\"status\"] == \"disabled\"'>{{'workflow.disabled' | translate}}</span>
"
        getStatus: (id)->
          $scope.workflows[id]
      }
    ]
    menu:null
    callback: tableCallback
    onLoad: (result)->
      $timeout ()->
        $scope.getStatus().then (result)->
          $scope.workflows = result.workflows
      , 500

  vm
]
