angular
.module('app')
.config ['$routeProvider', '$locationProvider', '$stateProvider'
($routeProvider, $locationProvider, $stateProvider) ->

  $stateProvider

    .state(
      name: "dashboard.notifr"
      url: "notifr"
      abstract: true
      views:
        '@dashboard':
          templateUrl: '/notifr/templates/notifr.html'
    )

    .state(
      name: "dashboard.notifr.index"
      url: ""
      views:
        '@dashboard.notifr':
          templateUrl: '/notifr/templates/notifr.index.html'
          controller: 'notifrIndexCtrl'
    )

    .state(
      name: "dashboard.notifr.settings"
      url: "/settings"
      views:
        '@dashboard.notifr':
          templateUrl: '/notifr/templates/notifr.settings.html'
          controller: 'notifrSettingsCtrl'
    )

    .state(
      name: "dashboard.notifr.new_notification"
      url: "/new_notification"
      templateUrl: '/notifr/templates/notifr.new.html'
      controller: 'notifrNewCtrl as ctrl'
    )

    .state(
      name: "dashboard.notifr.template_list"
      url: "/template_list"
      templateUrl: '/notifr/templates/template.index.html'
      controller: 'templateIndexCtrl as ctrl'
    )

    .state(
      name: "dashboard.notifr.template"
      url: "/template/:name"
      templateUrl: '/notifr/templates/template.edit.html'
      controller: 'templateEditCtrl as ctrl'
    )

    .state(
      name: "dashboard.notifr.new_template"
      url: "/template"
      templateUrl: '/notifr/templates/template.edit.html'
      controller: 'templateEditCtrl as ctrl'
    )

    .state(
      name: "dashboard.notifr.items"
      url: "/items"
      templateUrl: '/notifr/templates/template.item.html'
      controller: 'templateItemCtrl as ctrl'
    )

]
