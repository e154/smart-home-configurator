angular
.module('appControllers')
.controller 'bpmnViewerCtrl', ['$scope', 'Flow', '$stateParams', '$state', '$timeout', 'bpmnMock'
'bpmnScheme', 'bpmnSettings'
($scope, Flow, $stateParams, $state, $timeout, bpmnMock, bpmnScheme, bpmnSettings) ->
  vm = this

  # settings
  #------------------------------------------------------------------------------
  settings =
    engine:
      container:
        zoom: true
    theme:
      root_path: "/static/themes"

  # redactor
  #------------------------------------------------------------------------------
  redactor = new bpmnScheme($('#scheme1'))
  redactor.setSettings(settings)

  # prepare scheme
  #------------------------------------------------------------------------------
  $scope.$watch 'flow', (scheme)->
    if !scheme || !scheme?.name
      return
    redactor.start()
    redactor.setScheme(angular.copy(scheme))

  vm
]