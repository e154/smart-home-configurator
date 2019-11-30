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
]
