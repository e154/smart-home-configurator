angular
.module('app')
.config ['$routeProvider', '$locationProvider', '$stateProvider'
($routeProvider, $locationProvider, $stateProvider) ->

  $stateProvider

    .state(
      name: "dashboard.mqtt"
      url: "mqtt"
      abstract: true
      views:
        '@dashboard':
          templateUrl: '/mqtt/templates/mqtt.html'
          controller: 'mqttCtrl as mqtt'
    )

    .state(
      name: "dashboard.mqtt.index"
      url: ""
      views:
        '@dashboard.mqtt':
          templateUrl: '/mqtt/templates/mqtt.index.html'
          controller: 'mqttIndexCtrl as mqtt'
    )

    .state(
      name: "dashboard.mqtt.client_show"
      url: "/client/:id"
      templateUrl: '/mqtt/templates/mqtt_client_show.html'
      controller: 'mqttClientShowCtrl as mqtt'
    )

    .state(
      name: "dashboard.mqtt.publish"
      url: "/publish"
      templateUrl: '/mqtt/templates/mqtt_publish.html'
      controller: 'mqttPublishCtrl'
    )

    .state(
      name: "dashboard.mqtt.zigbee2mqtt"
      url: "/zigbee2mqtt"
      templateUrl: '/mqtt/templates/zigbee2mqtt.html'
      controller: 'zigbee2mqttCtrl'
    )

    .state(
      name: "dashboard.mqtt.zigbee2mqtt_new"
      url: "/zigbee2mqtt/new"
      templateUrl: '/mqtt/templates/zigbee2mqtt_new.html'
      controller: 'zigbee2mqttNewCtrl'
    )

    .state(
      name: "dashboard.mqtt.zigbee2mqtt_show"
      url: "/zigbee2mqtt/:id"
      templateUrl: '/mqtt/templates/zigbee2mqtt_show.html'
      controller: 'zigbee2mqttShowCtrl'
    )

    .state(
      name: "dashboard.mqtt.zigbee2mqtt_edit"
      url: "/zigbee2mqtt/:id/edit"
      templateUrl: '/mqtt/templates/zigbee2mqtt_edit.html'
      controller: 'zigbee2mqttEditCtrl'
    )

]
