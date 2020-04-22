angular
.module('app')
.config ['$routeProvider', '$locationProvider', '$stateProvider'
($routeProvider, $locationProvider, $stateProvider) ->

  $stateProvider

    .state(
      name: "dashboard.metric"
      url: "metric"
      abstract: true
      views:
        '@dashboard':
          templateUrl: '/metric/templates/metric.html'
          controller: 'metricCtrl'
    )

    .state(
      name: "dashboard.metric.index"
      url: ""
      views:
        '@dashboard.metric':
          templateUrl: '/metric/templates/metric.index.html'
          controller: 'metricIndexCtrl'
    )

    .state(
      name: "dashboard.metric.show"
      url: "/:id"
      templateUrl: '/metric/templates/metric.show.html'
      controller: 'metricShowCtrl'
    )
]
