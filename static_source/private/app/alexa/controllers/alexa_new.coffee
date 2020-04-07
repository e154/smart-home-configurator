angular
.module('appControllers')
.controller 'alexaNewCtrl', ['$scope', 'Notify', 'Alexa', '$state', 'Message'
($scope, Notify, Alexa, $state, Message) ->

  $scope.alexa = new Alexa({
    application_id: 'application'
    status: "enabled"
    description: "application"
    on_session_end_script_id: null
    on_launch_script_id: null
  })

  $scope.submit =->
    success =(data)->
      $state.go("dashboard.alexa.show", {id: data.id})

    error =(result)->
      Message result.data.status, result.data.message

    $scope.alexa.$create(success, error)


]
