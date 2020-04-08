angular
.module('appControllers')
.controller 'alexaShowCtrl', ['$scope', 'Notify', 'Alexa', '$stateParams', '$state', 'Message'
($scope, Notify, Alexa, $stateParams, $state, Message) ->
  $scope.alexa = {}

  get =->
    success = (alexa) ->
      $scope.alexa = angular.copy alexa
    error = ->
      $state.go 'dashboard.alexa.index'

    Alexa.show {id: $stateParams.id}, success, error

  $scope.remove =->
    success =->
      $state.go 'dashboard.alexa.index'
    error =(result)->
      Notify 'error', result.error, 3

    Alexa.delete {id: $stateParams.id}, success, error

  $scope.submit =->
    success =->
      get()
    error =(result)->
      Message result.data.status, result.data.message

    angular.forEach $scope.alexa.intents, (intent)->
      if !intent?.script_id && intent.script
        intent.script_id = intent.script.id

    if $scope.alexa?.on_session_end_script
      $scope.alexa.on_session_end_script_id = $scope.alexa.on_session_end_script.id

    if $scope.alexa?.on_launch_script
      $scope.alexa.on_launch_script_id = $scope.alexa.on_launch_script.id

    Alexa.update $scope.alexa, success, error

  $scope.addNewIntent =->
    intent =
      name: 'new intent'
      description: 'new intent'
      script: null
      alexa_skill_id: $scope.alexa.id

    if !$scope.alexa?.intents
      $scope.alexa.intents = []
    $scope.alexa.intents.push intent

  $scope.removeIntent =($event, intent)->
    $event.preventDefault()
    index = $scope.alexa.intents.indexOf(intent)
    if index == -1
      if !$scope.options.multiple && $scope.alexa.intents.length
        $scope.alexa.intents[0].selected = false
        $scope.alexa.intents.splice(0, 1)

      $scope.alexa.intents.push(intent)
      intent.selected = true
    else
      $scope.alexa.intents.splice(index, 1)
      intent.selected = false

  get()
]
