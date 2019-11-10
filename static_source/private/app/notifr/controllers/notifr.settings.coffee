angular
  .module('appControllers')
  .controller 'notifrSettingsCtrl', ['$scope', 'Notifr', 'Message', '$http', 'Notify', 'EmailTemplateSelect2'
  ($scope, Notifr, Message, $http, Notify, EmailTemplateSelect2) ->
    $scope.settings =
      email_auth: ""
      email_pass: ""
      email_port: 0
      email_sender: ""
      email_smtp: ""
      mb_access_key: ""
      mb_name: ""
      telegram_token: ""
      tw_auth_token: ""
      tw_from: ""
      tw_sid: ""
      slack_token: ""
      slack_user_name: ""

    getSettings = ->
      success = (result)->
        $scope.settings = result
      error = (result)->
        Message result.data.status, result.data.message

      Notifr.get_config {}, success, error

    $scope.updateSettings = ->
      success = ->
        Notify 'success', 'Settings updated', 3
      error = (result)->
        Message result.data.status, result.data.message

      Notifr.update_config $scope.settings, success, error

    getSettings()

]
