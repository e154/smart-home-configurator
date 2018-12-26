angular
.module('appControllers')
.controller 'scriptIndexCtrl', ['$scope', 'Notify', 'Script', '$state', '$timeout'
($scope, Notify, Script, $state, $timeout) ->
  vm = this

  tableCallback = {}
  vm.options =
    perPage: 20
    resource: Script
    columns: [
      {
        name: '#'
        field: 'id'
        width: '35px'
      }
      {
        name: 'script.name'
        field: 'name'
        width: '150px'
        clickCallback: ($event, item)->
          $event.preventDefault()
          $state.go('dashboard.script.edit', {id: item.id})
          false
      }
      {
        name: 'script.lang'
        field: 'lang'
        width: '100px'
      }
      {
        name: 'script.description'
        field: 'description'

      }
      {
        name: 'script.created_at'
        field: 'created_at'
        template: '<span>{{item[field] | readableDateTime}}</span>'
        width: '150px'
      }
      {
        name: 'script.updated_at'
        field: 'updated_at'
        template: '<span>{{item[field] | readableDateTime}}</span>'
        width: '150px'
      }
    ]
    menu:null
    callback: tableCallback
    onLoad: (result)->

  vm
]