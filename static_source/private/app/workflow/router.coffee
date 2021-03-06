angular
.module('app')
.config ['$routeProvider', '$locationProvider', '$stateProvider'
($routeProvider, $locationProvider, $stateProvider) ->

  $stateProvider

    .state(
      name: "dashboard.workflow"
      url: "workflow"
      abstract: true
      views:
        '@dashboard':
          templateUrl: '/workflow/templates/workflow.html'
          controller: 'workflowCtrl as workflow'
    )

    .state(
      name: "dashboard.workflow.index"
      url: ""
      views:
        '@dashboard.workflow':
          templateUrl: '/workflow/templates/workflow.index.html'
          controller: 'workflowIndexCtrl as workflow'
    )

    .state(
      name: "dashboard.workflow.new"
      url: "/new"
      templateUrl: '/workflow/templates/workflow.new.html'
      controller: 'workflowNewCtrl as workflow'
    )

    .state(
      name: "dashboard.workflow.show"
      url: "/:id"
      views:
        "":
          templateUrl: '/workflow/templates/workflow.show.html'
          controller: 'workflowShowCtrl as workflow'
        "tab-view@dashboard.workflow.show":
          templateUrl: '/workflow/templates/workflow.scenarios.html'
          controller: 'workflowScenariosCtrl as scenarios'
    )

    .state(
      name: "dashboard.workflow.show.scripts"
      url: "/scripts"
      views:
        "tab-view@dashboard.workflow.show":
          templateUrl: '/workflow/templates/workflow.scripts.html'
          controller: 'workflowScriptsCtrl as ws'
    )

    .state(
      name: "dashboard.workflow.edit"
      url: "/:id/edit"
      templateUrl: '/workflow/templates/workflow.edit.html'
      controller: 'workflowEditCtrl as workflow'
    )

]
