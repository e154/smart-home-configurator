angular
.module('app')
.config ['$routeProvider', '$locationProvider', '$stateProvider'
($routeProvider, $locationProvider, $stateProvider) ->

  $stateProvider

    .state(
      name: "dashboard.scenario"
      url: "scenario"
      abstract: true
      views:
        '@dashboard':
          templateUrl: '/scenario/templates/scenario.html'
          controller: 'scenarioCtrl as scenario'
    )

    .state(
      name: "dashboard.scenario.index"
      url: ""
      views:
        '@dashboard.scenario':
          templateUrl: '/scenario/templates/scenario.index.html'
          controller: 'scenarioIndexCtrl'
    )

    .state(
      name: "dashboard.scenario.new"
      url: "/new"
      templateUrl: '/scenario/templates/scenario.new.html'
      controller: 'scenarioNewCtrl'
    )

    .state(
      name: "dashboard.scenario.show"
      url: "/:id"
      templateUrl: '/scenario/templates/scenario.show.html'
      controller: 'scenarioShowCtrl'
    )

    .state(
      name: "dashboard.scenario.edit"
      url: "/:id/edit"
      templateUrl: '/scenario/templates/scenario.edit.html'
      controller: 'scenarioEditCtrl'
    )

]
