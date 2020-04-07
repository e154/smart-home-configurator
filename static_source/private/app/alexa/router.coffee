angular
.module('app')
.config ['$routeProvider', '$locationProvider', '$stateProvider'
($routeProvider, $locationProvider, $stateProvider) ->

  $stateProvider

    .state(
      name: "dashboard.alexa"
      url: "alexa"
      abstract: true
      views:
        '@dashboard':
          templateUrl: '/alexa/templates/alexa.html'
          controller: 'alexaCtrl'
    )

    .state(
      name: "dashboard.alexa.index"
      url: ""
      views:
        '@dashboard.alexa':
          templateUrl: '/alexa/templates/alexa_index.html'
          controller: 'alexaIndexCtrl'
    )

    .state(
      name: "dashboard.alexa.show"
      url: "/:id"
      templateUrl: '/alexa/templates/alexa_show.html'
      controller: 'alexaShowCtrl'
    )

]
