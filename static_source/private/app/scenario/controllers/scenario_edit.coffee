angular
.module('appControllers')
.controller 'scenarioEditCtrl', ['$scope', 'Message', '$stateParams', 'Scenario', '$state', 'Notify'
($scope, Message, $stateParams, Scenario, $state, Notify) ->

  Scenario.show {id: $stateParams.id}, (scenario)->
    $scope.scenario = scenario

  $scope.remove =->
    if confirm('точно удалить сценарий?')
      remove()

  remove =->
    success =->
      $state.go("dashboard.scenario.index")
    error =(result)->
      Message result.data.status, result.data.message
    $scope.scenario.$delete success, error

  $scope.submit =->
    success =(data)->
      Notify 'success', 'Сценарий успешно сохранен', 3

    error =(result)->
      Message result.data.status, result.data.message

    $scope.scenario.$update(success, error)

]