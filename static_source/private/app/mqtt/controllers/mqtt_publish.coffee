angular
.module('appControllers')
.controller 'mqttPublishCtrl', ['$scope', 'Notify', 'Mqtt', '$state', '$filter', 'Message'
($scope, Notify, Mqtt, $state, $filter, Message) ->
  vm = this

  $scope.msg =
    qos: 0
    retain: true
    topic: "home/node/node1/req"
    payload: "{\"device_id\":2,\"device_type\":\"command\",\"properties\":{},\"command\":{\"name\":\"./data/scripts/ping.sh\",\"args\":[\"ya.ru\"]}}"

  $scope.submit =->
    success = () ->

    error = ->
      Message result.data.status, result.data.message

    msg =
      qos: $scope.msg.qos
      retain: $scope.msg.retain
      topic: $scope.msg.topic
      payload: btoa($scope.msg.payload)

    Mqtt.publish msg, success, error

  vm
]
