angular
.module('appControllers')
.controller 'bpmnEditorCtrl', ['$scope', 'Notify', 'Flow', '$stateParams', '$state', '$timeout', 'bpmnMock'
'bpmnScheme', 'bpmnSettings', '$http', 'log', 'Worker', 'ngDialog', '$filter', 'Stream', 'DeviceActionSelect2',
'ScriptSelect2', 'FlowSelect2', 'MqttTopicSelect2', 'Zigbee2mqttSelect2'
($scope, Notify, Flow, $stateParams, $state, $timeout, bpmnMock, bpmnScheme, bpmnSettings, $http
log, Worker, ngDialog, $filter, Stream, DeviceActionSelect2, ScriptSelect2, FlowSelect2, MqttTopicSelect2,
Zigbee2mqttSelect2) ->

  vm = this

  $scope.selected = []
  $scope.selectedConn =
    title: ""
    object: ""
    direction: ""
  $scope.directions = [
    {
      name: $filter('translate')('true')
      value: "true"
    }
    {
      name: $filter('translate')('false')
      value: "false"
    }
    {
      name: $filter('translate')('no mater')
      value: ""
    }
  ]

  # settings
  #------------------------------------------------------------------------------
  settings =
    engine:
      status: 'editor'
    theme:
      root_path: "/static/themes"
    editorPallet:
      groups: [
        {
          name: 'event'
          items: [
            {
              type:
                name: 'event'
                start:
                  0:
                    0: true
              title: 'start'
              class: 'bpmn-icon-start-event-none'
              tooltip: 'Create start event'
              shape: bpmnSettings.template('event')
            }
            {
              type:
                name: 'event'
                end:
                  simply:
                    top_level: true
              title: 'end'
              class: 'bpmn-icon-end-event-none'
              tooltip: 'Create end event'
              shape: bpmnSettings.template('event')
            }
          ]
        }
        {
          name: 'gateway'
          items: [
            {
              type:
                name: 'gateway'
                start:
                  0:
                    0: true
              title: 'gateway'
              class: 'bpmn-icon-gateway-xor'
              tooltip: 'Create gateway'
              shape: bpmnSettings.template('gateway')
            }
          ]
        }
        {
          name: 'task'
          items: [
            {
              type:
                name: 'task'
              title: 'task'
              class: 'bpmn-icon-task-none'
              tooltip: 'Create task'
              shape: bpmnSettings.template('task')
            }
          ]
        }
        {
          name: 'flow'
          items: [
            {
              type:
                name: 'flow'
              title: 'flow'
              class: 'bpmn-icon-participant'
              tooltip: 'Create flow link'
              shape: bpmnSettings.template('flow')
            }
          ]
        }
      ]


  # redactor
  #------------------------------------------------------------------------------
  $scope.redactor = redactor = new bpmnScheme($('#scheme1'))
  redactor.setSettings(settings)

  $scope.$watch 'flow', (scheme)->
    if !scheme || !scheme?.name
      return
    redactor.start()
    redactor.setScheme(scheme)

  $scope.serialise =->
    $scope.scheme = redactor.getScheme()

  $scope.callback['save']= ()->
    $scope.serialise()

  $timeout ()->
    $scope.$apply(
      $scope.callback
    )

  $scope.removeElement =(element, $index)->
    index = $scope.selected.indexOf(element)
    object =
      id: element.data.id
      type: 'shape'
    $scope.redactor.removeObject(object)

    if index > -1
      $scope.selected.splice(index, 1)

  # select element on scheme
  #------------------------------------------------------------------------------
  redactor.scope.$watch 'selected', (selected)=>
    return if !selected

    $scope.selected = []
    connections = redactor.getAllConnections()
    connection = null
    for object in selected
      angular.forEach $scope.redactor.scope.intScheme.objects, (obj, key)->
        if key == object.id
          $scope.selected.push obj
          if !$scope.elementScripts.hasOwnProperty(obj.data.id)
            $scope.elementScripts[obj.data.id] = null

          if !$scope.elementFlows.hasOwnProperty(obj.data.id)
            $scope.elementFlows[obj.data.id] = null

      # connections
      if object.type != "connector"
        continue

      angular.forEach connections, (conn)->
        if object.id == conn.id
          connection = conn

    if connection?
      $scope.selectedConn =
        title: redactor.getLabel(connection)
        direction: connection.getParameter("direction") || ""
        object: connection
    else $scope.selectedConn =
        object: null

    $timeout ()->
      $scope.$apply()

  , true

  # workers
  #------------------------------------------------------------------------------
  $scope.addNewWorker =->
    worker = new Worker({
      name: 'Действие'
      time: '* * * * * *'
      status: 'enabled'
      flow:
        id: parseInt($stateParams.id, 10)
      device_action: null
      workflow:
        id: $scope.flow.workflow.id
    })

    $scope.flow.workers.push worker

  $scope.removeWorker =(worker, $index)->
    if !worker.id
      $scope.flow.workers.splice($index, 1)
      return

    for i in [0...$scope.flow.workers.length]
      if $scope.flow.workers[i].id == worker.id
        $scope.flow.workers.splice(i, 1)
        break

  $scope.doWorker =(worker, $index)->
    return if !worker.id
    Stream.sendRequest("do.worker", {worker_id: worker.id}).then (result)->
      if !result.error
        Notify 'success', "Command executed successfully", 3
      else
        Notify 'error', result.error, 3

  # get device actions (select2)
  $scope.actions = []
  $scope.refreshActions = DeviceActionSelect2 (actions)-> $scope.actions = actions

  # select scripts for flow elements (select2)
  $scope.scripts = []
  $scope.refreshScripts = ScriptSelect2 (scripts)-> $scope.scripts = scripts

  # scripts
  #------------------------------------------------------------------------------
  $scope.showScript =(script, e)->
    e.preventDefault()
    $scope.script = script

    ngDialog.open
      scope: $scope
      showClose: false
      template: '/script/templates/modal.show.html'
      className: 'ngdialog-theme-default ngdialog-scripts-show'
      controller: 'scriptModalShowCtrl'
      controllerAs: 'script'

  $scope.addScript =(id, e)->
    e.preventDefault()
    $scope.setScript = (script)->
      $scope.elementScripts[id] = script

    ngDialog.open
      scope: $scope
      showClose: false
      closeByEscape: false
      closeByDocument: false
      template: '/script/templates/modal.new.html'
      className: 'ngdialog-theme-default ngdialog-scripts-edit'
      controller: 'scriptModalNewCtrl'
      controllerAs: 'script'

  $scope.editScript =(elementScripts, id, e)->
    e.preventDefault()
    $scope.script = elementScripts[id]
    $scope.setScript = (script)->
      $scope.elementScripts[id] = script

    ngDialog.open
      scope: $scope
      showClose: false
      closeByEscape: false
      closeByDocument: false
      template: '/script/templates/modal.edit.html'
      className: 'ngdialog-theme-default ngdialog-scripts-edit'
      controller: 'scriptModalEditCtrl'
      controllerAs: 'script'

  # connections
  #------------------------------------------------------------------------------
  $scope.setDirection =->
    return if !$scope.selectedConn
    direction = $scope.selectedConn.direction
    $scope.selectedConn.object.setParameter("direction", direction)

  $scope.setLabel =->
    return if !$scope.selectedConn
    conn = $scope.selectedConn.object
    redactor.setLabel(conn, $scope.selectedConn.title)

  # flows
  #------------------------------------------------------------------------------
  # select flows for flow elements (select2)
  $scope.flows = []
  $scope.refreshFlows = FlowSelect2 (flows)->
    $scope.flows = []
    angular.forEach flows, (flow)->
      if flow.id != $scope.flow.id
        $scope.flows.push flow

  # mqtt topics
  #------------------------------------------------------------------------------
  $scope.mqttSelect =
    current: {}

  $scope.mqttTopics = []

  $scope.refreshMqttTopics = MqttTopicSelect2 (topics)->
    $scope.mqttTopics = []
    angular.forEach topics, (topic)->
      obj =
        topic: topic.name
      $scope.mqttTopics.push obj

  $scope.removeTopic =(topic, $index)->
    $scope.flow.subscriptions.splice($index, 1)
    return

  $scope.addTopic =(e)->
    e.preventDefault()

    contains = false
    angular.forEach $scope.flow.subscriptions, (sub)->
      if sub.topic == $scope.mqttSelect.current.topic
        contains = true
        return

    if !contains
      $scope.flow.subscriptions.push $scope.mqttSelect.current

  # zigbee2mqtt subscribe
  #------------------------------------------------------------------------------
  $scope.zigbee2mqttSelect =
    current: {}

  $scope.zigbee2mqttDevices = []

  $scope.refreshZigbee2mqttDeviceList = Zigbee2mqttSelect2 (devices)->
    $scope.zigbee2mqttDevices = []
    angular.forEach devices, (device)->
      obj =
        id: device.id
        name: device.name
        description: device.description
      $scope.zigbee2mqttDevices.push obj

  $scope.addZigbee2mqttDevice =(e)->
    e.preventDefault()

    angular.forEach $scope.flow.zigbee2mqtt_devices, (dev)->
      if dev.id == $scope.zigbee2mqttSelect.current.id
        return

    $scope.flow.zigbee2mqtt_devices.push $scope.zigbee2mqttSelect.current


  $scope.removeZigbee2mqttDevice =(topic, $index)->
    $scope.flow.zigbee2mqtt_devices.splice($index, 1)
    return

  vm
]
