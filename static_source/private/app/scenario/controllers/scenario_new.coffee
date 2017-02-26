angular
.module('appControllers')
.controller 'scenarioNewCtrl', ['$scope', 'Notify', 'Scenario', '$state', 'Message'
($scope, Notify, Scenario, $state, Message) ->

  $scope.scenario = new Scenario({
    name: "Новый Сценарий"
    system_name: ""
  })

  $scope.submit =->
    success =(data)->
      $state.go("dashboard.scenario.show", {id: data.id})

    error =(result)->
      Message result.data.status, result.data.message

    $scope.scenario.$create(success, error)

]