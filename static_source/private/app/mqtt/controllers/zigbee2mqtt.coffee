angular
.module('appControllers')
.controller 'zigbee2mqttCtrl', ['$scope', 'Notify', 'Zigbee2mqtt', '$state', '$filter', 'ifCan'
($scope, Notify, Zigbee2mqtt, $state, $filter, ifCan) ->

  tableCallback = {}
  $scope.options =
    perPage: 20
    resource: Zigbee2mqtt
    columns: [
      {
        name: '#'
        field: 'id'
        template: '<span>{{item.model.id}}</span>'
      }
      {
        name: 'zigbee2mqtt.base_topic'
        field: 'base_topic'
        template: '<span>{{item.model.base_topic}}</span>'
        clickCallback: ($event, item)->
          $event.preventDefault()
          $state.go('dashboard.mqtt.zigbee2mqtt_show', {id: item.model.id})

          false
      }
      {
        name: 'zigbee2mqtt.permit_join'
        field: 'permit_join'
        width: '100px'
        template: '<span class=\'label label-success\' ng-if=\'item.model.permit_join\'>{{\"zigbee2mqtt.on\" | translate}}</span>
<span class=\'label label-default\' ng-if=\'!item.model.permit_join\'>{{\"zigbee2mqtt.off\" | translate}}</span>'
      }
      {
        name: 'zigbee2mqtt.created_at'
        field: 'created_at'
        width: '160px'
        template: '<span>{{item.model[field] | readableDateTime}}</span>'
      }
      {
        name: 'zigbee2mqtt.updated_at'
        field: 'updated_at'
        width: '160px'
        template: '<span>{{item.model[field] | readableDateTime}}</span>'
      }
      {
        name: 'zigbee2mqtt.status'
        sort: 'disable'
        width: '50px'
        template: '<span class=\'label label-default\' ng-if=\'item[\"status\"] != \"online\"\'>{{\"zigbee2mqtt.offline\" | translate}}</span>
<span class=\'label label-success\' ng-if=\'item[\"status\"] == \"online\"\'>{{\"zigbee2mqtt.online\" | translate}}</span>'
      }

    ]
    callback: tableCallback
    onLoad: (result)->


]
