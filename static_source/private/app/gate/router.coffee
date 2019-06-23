angular
.module('app')
.config ['$routeProvider', '$locationProvider', '$stateProvider'
($routeProvider, $locationProvider, $stateProvider) ->

  $stateProvider

    .state(
      name: "dashboard.gate"
      url: "gate"
      abstract: true
      views:
        '@dashboard':
          templateUrl: '/gate/templates/gate.html'
          controller: 'gateCtrl'
    )

    .state(
      name: "dashboard.gate.index"
      url: ""
      views:
        '@dashboard.gate':
          templateUrl: '/gate/templates/gate.index.html'
          controller: 'gateIndexCtrl'
    )
]
