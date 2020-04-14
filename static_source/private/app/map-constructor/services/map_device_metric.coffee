angular
.module('angular-map')
.factory 'MapDeviceMetric', () ->
  class MapDeviceMetric

    id: null
    name: ''
    description: ''
    translations: "{\"time\":\"time\"}"

    constructor: (@scope, @map_device_id)->

    serialize: ()->
      {
        id: @id if @id
        name: @name
        map_device_id: @map_device_id
        description: @description || ''
        translations: angular.fromJson(@translations)
      }

    deserialize: (m)->
      @id = m.id if m.id
      @name = m.name if m.name
      @description = m.description || ''
      @translations = angular.toJson(m.translations)

      @

  MapDeviceMetric
