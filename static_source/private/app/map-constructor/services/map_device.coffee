angular
  .module('angular-map')
  .factory 'MapDevice', ['$http', 'Message', 'Notify', 'DeviceState', 'MapDeviceState', 'DeviceAction',
  'MapDeviceAction', 'DeviceSelect2', 'MapDeviceMetric'
  ($http, Message, Notify, DeviceState, MapDeviceState, DeviceAction, MapDeviceAction, DeviceSelect2, MapDeviceMetric) ->
    class MapDevice

      id: null
      system_name: null
      scope: null
      device: null
      devices: []
      states: []
      actions: []
      metrics: []
      image: null

      constructor: (@scope)->
        @scope.$watch(()=>
          @device
        , (val, old_val)=>
          return if !val || val == old_val
          @getDeviceStates(val)
          @getDeviceActions(val)
        )

      getDeviceActions: (device)->
        success = (actions)=>
          @device.actions = actions
          @actions = []
          angular.forEach @device.actions, (device_action)=>
            md_action = new MapDeviceAction(@scope, device_action)
            @actions.push md_action
        error = (result)->
          Message result.data.status, result.data.message

        DeviceAction.get_by_device {id: device.device?.id || device.id}, success, error

      getDeviceStates: (device)->
        success = (states)=>
          @device.states = states
          @states = []
          angular.forEach @device.states, (device_state)=>
            md_state = new MapDeviceState(@scope, device_state)
            @states.push md_state

        error = (result)->
          Message result.data.status, result.data.message
        DeviceState.get_by_device {id: device.device?.id || device.id}, success, error

# get devices (select2)
      refreshDevices: (args)=>
        _this = @

        DeviceSelect2((devices)=>
          angular.forEach devices, (device, index)->
#if !device.device_id? && !device.address?
#  devices.splice(index, 1)
            _this.devices = devices
        )(args)


      serialize: ()->
        return if !@device

        states = []
        angular.forEach @states, (_state)=>
          state = _state.serialize()
          state.map_device = {id: @id} if @id
          states.push state

        actions = []
        angular.forEach @actions, (_action)=>
          action = _action.serialize()
          action.map_device = {id: @id} if @id
          actions.push action

        metrics = []
        angular.forEach @metrics, (_metric)->
          metric = _metric.serialize()
          metrics.push metric

        {
          id: @id if @id
          device: {id: @device.id} if @device
          device_id: @device.id if @device
          states: states
          actions: actions
          metrics: metrics
          image: @image
          system_name: @system_name
        }

      deserialize: (m)=>
        @id = m.id if m.id
        @device = m.device if m.device
        @status = m.status || 'enabled'
        @image = m.image || null
        @system_name = m.system_name || null

        @states = []
        angular.forEach @device.states, (device_state)=>
          md_state = new MapDeviceState(@scope, device_state)
          angular.forEach m.states, (state)=>
            if state.device_state?.id && state.device_state.id == device_state.id
              md_state.deserialize state
          @states.push md_state

        @actions = []
        angular.forEach @device.actions, (device_action)=>
          md_action = new MapDeviceAction(@scope, device_action)
          angular.forEach m.actions, (action)=>
            if action.device_action?.id && action.device_action.id == device_action.id
              md_action.deserialize action
          @actions.push md_action

        @metrics = []
#        angular.forEach m.metrics, (metric, key)=>
#          md_action = new MapDeviceMetric(@scope, m.id)
#          md_action.deserialize metric
#          @metrics.push md_action

        @

      removeImage: ()->
        @image = null

      create: ()->
      update: ()->
      remove: ()->
      update: (cb)->
        @upload(cb)

      valid: =>
        @device != null

      addNewMetric: ()->
#        md_action = new MapDeviceMetric(@scope, @id)
#        @metrics.push md_action

      removeMetric: ($event, metric)->
#        $event.preventDefault()
#        index = @metrics.indexOf(metric)
#        @metrics.splice(index, 1)


    MapDevice
]
