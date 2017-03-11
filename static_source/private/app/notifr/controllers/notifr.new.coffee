angular
.module('appControllers')
.controller 'notifrNewCtrl', ['$scope', 'Notifr','Message','$http'
($scope, Notifr, Message, $http) ->

  $scope.message = {}

  # select2
  # ------------------
  $scope.templates = []
  $scope.refreshTemplateList = (query)->
    $http(
      method: 'GET'
      url: window.app_settings.server_url + "/api/v1/email/template/search"
      params:
        query: query
        limit: 10
        offset: 0
    ).then (response)->
      $scope.templates = response.data.templates

  $scope.send =->
    success =->
      $scope.$parent.update()
      $scope.closeThisDialog()
    error =(result)->
      Message result.data.status, result.data.message
    Notifr.post $scope.message, success, error
]
