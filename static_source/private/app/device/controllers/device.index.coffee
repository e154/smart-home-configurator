angular
.module('appControllers')
.controller 'deviceIndexCtrl', ['$scope', 'Device', '$state', 'Node'
($scope, Device, $state, Node) ->
  vm = this

  Node.all {
    limit: 99
    offset: 0
    order: 'desc'
    query: {}
    sortby: 'created_at'
  }, (data)->
    vm.nodes = data.nodes

  tableCallback = {}
  vm.options =
    perPage: 20
    resource: Device
    columns: [
      {
        name: '#'
        field: 'id'
      }
      {
        name: 'device.name'
        field: 'name'
        clickCallback: ($event, item)->
          $event.preventDefault()
          $state.go('dashboard.device.show', {id: item.id})
          false
      }
      {
        name: 'device.type'
        field: 'type'
        template: "<span ng-if='!item[field]'>-</span>
<span ng-if='item[field]'>{{item[field]}}</span>"
      }
      {
        name: 'device.is_group'
        sort: 'disable'
        field: 'is_group'
        template: "<span ng-if='item[field]'>{{'device.yes' | translate}}</span>"
      }
      {
        name: 'device.parent'
        field: 'device_id'
        template: '<span>{{item["device"].name}}</span>'
        clickCallback: ($event, item)->
          $event.preventDefault()
          $state.go('dashboard.device.show', {id: item.device.id})
          false
      }
      {
        name: 'device.node'
        field: 'node_id'
        template: "<a href='' ui-sref='dashboard.node.show({id:item[field].id})'>{{item['node'].name}}</a>"
      }
      {
        name: 'device.created_at'
        field: 'created_at'
        template: '<span>{{item[field] | readableDateTime}}</span>'
      }
      {
        name: 'device.updated_at'
        field: 'updated_at'
        template: '<span>{{item[field] | readableDateTime}}</span>'
      }
      {
        name: 'device.status.name'
        field: 'status'
        width: '50px'
        template: "
<span class='label label-success' ng-if='item[\"status\"] == \"enabled\"'>{{'device.enabled' | translate}}</span>
<span class='label label-default' ng-if='item[\"status\"] == \"disabled\"'>{{'device.disabled' | translate}}</span>
"
      }
    ]
    menu:null
    rows: (item)->
      style
      if item.is_group
        style = 'bg-warning'
      style

    callback: tableCallback

  vm
]