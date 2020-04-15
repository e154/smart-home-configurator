angular
.module('angular-map')
.factory 'MapDeviceMetric', () ->
  class MapDeviceMetric

    id: null
    name: ''
    description: ''
    optionItems: []

    constructor: (@scope, @map_device_id)->

    serialize: ()->
      options =
        items: @optionItems
      {
        id: @id if @id
        name: @name
        map_device_id: @map_device_id
        description: @description || ''
        options: options
      }

    deserialize: (m)->
      @id = m.id if m.id
      @name = m.name if m.name
      @description = m.description || ''
      if m.options?.items
        @optionItems = m.options.items

      @

    addNewOptionItem: ->
      @optionItems.push {
        "name": "temperature",
        "translate": "Temperature",
        "description": "Temperature",
        "color": "#0000ff"
      }

    removeOptionItem: ($event, item)->
      console.log '---'
      $event.preventDefault()
      index = @optionItems.indexOf(item)
      @optionItems.splice(index, 1)

  MapDeviceMetric
