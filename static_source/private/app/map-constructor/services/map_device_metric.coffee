angular
.module('angular-map')
.factory 'MapDeviceMetric', () ->
  class MapDeviceMetric

    id: null
    name: ''
    description: ''
    options: "{\"time\":\"time\"}"

    constructor: (@scope, @map_device_id)->

    serialize: ()->
      {
        id: @id if @id
        name: @name
        map_device_id: @map_device_id
        description: @description || ''
        options: angular.fromJson(@options)
      }

    deserialize: (m)->
      @id = m.id if m.id
      @name = m.name if m.name
      @description = m.description || ''
      @options = angular.toJson(m.options)

      @

  MapDeviceMetric
