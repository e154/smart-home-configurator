angular
.module('appControllers')
.controller 'notifrNewCtrl', ['$scope', 'Notifr','Message','$http', 'Notify', 'EmailTemplateSelect2'
($scope, Notifr, Message, $http, Notify, EmailTemplateSelect2) ->

  $scope.message = {
    type: 'email'
    body_type: 'plain'  # plain|template
    template: ''
    params: {}
  }

  # select2
  # ------------------
  $scope.templates = []
  $scope.refreshTemplateList = EmailTemplateSelect2 (templates)-> $scope.templates = templates

  $scope.send =->
    success =->
      Notify 'success', 'Message successfully added to the handler', 3
    error =(result)->
      Message result.data.status, result.data.message

    message = angular.extend {}, $scope.message
    message.params = {} if !message.template?
    message.template = message.template.name if message.template
    Notifr.send message, success, error
]
