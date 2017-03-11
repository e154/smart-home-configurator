angular
.module('appControllers')
.controller 'notifrNewCtrl', ['$scope', 'Notifr','Message','$http', 'Notify'
($scope, Notifr, Message, $http, Notify) ->

  $scope.message = {
    type: 'email'
    template: ''
    params: {}
  }

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
      Notify 'success', 'Сообщение успешно добавлено в обработчик', 3
    error =(result)->
      Message result.data.status, result.data.message
    Notifr.send $scope.message, success, error
]
