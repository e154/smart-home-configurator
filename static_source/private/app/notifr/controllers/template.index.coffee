angular
.module('appControllers')
.controller 'templateIndexCtrl', ['$scope', 'Template','$state'
($scope, Template, $state) ->

  vm = this

  tableCallback = {}
  vm.options =
    perPage: 20
    resource: Template
    columns: [
      {
        name: 'notifr.system_name'
        field: 'name'
        width: '310px'
        template: '<strong>{{item[field]}}</strong>'
        clickCallback: ($event, item)->
          $event.preventDefault()
          $state.go('dashboard.notifr.template', {name: item.name})
          false
      }
      {
        name: 'notifr.description'
        field: 'description'
      }
      {
        name: 'notifr.created_at'
        field: 'created_at'
        width: '160px'
        template: '<span>{{item[field] | readableDateTime}}</span>'
      }
      {
        name: 'notifr.updated_at'
        field: 'updated_at'
        width: '160px'
        template: '<span>{{item[field] | readableDateTime}}</span>'
      }
    ]
    menu: null
    callback: tableCallback

  vm
]
