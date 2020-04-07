angular
.module('appControllers')
.controller 'alexaCtrl', ['$scope', 'Notify', 'Alexa', 'Stream', '$http', 'ngDialog'
($scope, Notify, Alexa, Stream, $http, ngDialog) ->

  # select2
  # ------------------
  $scope.scripts = []
  $scope.refreshScripts = (query)->
    $http(
      method: 'GET'
      url: "/api/v1/scripts/search"
      params:
        query: query
        limit: 5
        offset: 0
    ).then (response)->
      $scope.scripts = response.data.scripts

  # scripts
  #------------------------------------------------------------------------------
  $scope.showScript =(script, e)->
    e.preventDefault()
    $scope.script = script

    ngDialog.open
      scope: $scope
      showClose: false
      template: '/script/templates/modal.show.html'
      className: 'ngdialog-theme-default ngdialog-scripts-show'
      controller: 'scriptModalShowCtrl'
      controllerAs: 'script'

  $scope.addScript =(e)=>
    e.preventDefault()
    $scope.setScript =(s)=>
      #$scope.alexa.script = script
      script.source = s.source

    ngDialog.open
      scope: $scope
      showClose: false
      closeByEscape: false
      closeByDocument: false
      template: '/script/templates/modal.new.html'
      className: 'ngdialog-theme-default ngdialog-scripts-edit'
      controller: 'scriptModalNewCtrl'
      controllerAs: 'script'
      preCloseCallback: ()=>
        $scope.getDeviceActions()
        $scope.getDefaultAction()
        return

  $scope.editScript =(script, e)->
    e.preventDefault()
    $scope.script = script
    $scope.setScript =(s)=>
      #$scope.alexa.script = script
      script.source = s.source

    ngDialog.open
      scope: $scope
      showClose: false
      closeByEscape: false
      closeByDocument: false
      template: '/script/templates/modal.edit.html'
      className: 'ngdialog-theme-default ngdialog-scripts-edit'
      controller: 'scriptModalEditCtrl'
      controllerAs: 'script'
]
