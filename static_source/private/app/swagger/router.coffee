angular
.module('app')
.config ['$routeProvider', '$locationProvider', '$stateProvider'
($routeProvider, $locationProvider, $stateProvider) ->

  $stateProvider

    .state(
      name: "dashboard.swagger"
      url: "swagger"
      abstract: true
      views:
        '@dashboard':
          templateUrl: '/swagger/templates/swagger.html'
          controller: 'swaggerCtrl'
    )

    .state(
      name: "dashboard.swagger.index"
      url: ""
      views:
        '@dashboard.swagger':
          templateUrl: '/swagger/templates/swagger.index.html'
          controller: 'swaggerIndexCtrl'
    )
]
