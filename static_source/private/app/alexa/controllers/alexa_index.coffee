angular
.module('appControllers')
.controller 'alexaIndexCtrl', ['$scope', 'Notify', 'Alexa', '$state', '$timeout'
($scope, Notify, Alexa, $state, $timeout) ->
  tableCallback = {}
  $scope.options =
    perPage: 20
    resource: Alexa
    columns: [
      {
        name: '#'
        field: 'id'
        width: '50px'
      }
      {
        name: 'alexa.description'
        field: 'description'
        clickCallback: ($event, item)->
          $event.preventDefault()
          $state.go('dashboard.alexa.show', {id: item.id})
          false
      }
      {
        name: 'alexa.created_at'
        field: 'created_at'
        width: '160px'
        template: '<span>{{item[field] | readableDateTime}}</span>'
      }
      {
        name: 'alexa.updated_at'
        field: 'updated_at'
        width: '160px'
        template: '<span>{{item[field] | readableDateTime}}</span>'
      }
      {
        name: 'alexa.status'
        field: 'status'
        width: '50px'
        template: "
<span class='label label-success' ng-if='item[\"status\"] == \"enabled\"'>{{'alexa.enabled' | translate}}</span>
<span class='label label-default' ng-if='item[\"status\"] == \"disabled\"'>{{'alexa.disabled' | translate}}</span>
"
      }
    ]
    menu:null
    callback: tableCallback
    onLoad: (result)->

]
