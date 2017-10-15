angular
.module('appControllers')
.controller 'notifrNewCtrl', ['$scope', 'Notifr','Message','$http', 'Notify', 'EmailTemplateSelect2'
($scope, Notifr, Message, $http, Notify, EmailTemplateSelect2) ->

  $scope.message = {
    type: 'email'
    template: ''
    params: {}
  }

  # select2
  # ------------------
  $scope.templates = []
  $scope.refreshTemplateList = EmailTemplateSelect2 (templates)-> $scope.templates = templates

  $scope.send =->
    success =->
      Notify 'success', 'Сообщение успешно добавлено в обработчик', 3
    error =(result)->
      Message result.data.status, result.data.message

    message = angular.extend $scope.message
    message.params = {} if !message.template?
    Notifr.send message, success, error
]
