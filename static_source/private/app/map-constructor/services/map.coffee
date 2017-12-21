angular
.module('angular-map')
.factory 'mapConstructor', ['$rootScope', '$compile', 'MapResource', 'Message', 'Notify', 'mapEditor'
'MapLayer', '$translate', 'mapSettings'
  ($rootScope, $compile, MapResource, Message, Notify, mapEditor, MapLayer, $translate, mapSettings) ->
    class mapConstructor extends mapEditor

      id: null
      name: ''
      description: ''
      layers: null

      settings: null
      scope: null
      panning: null
      container: null
      wrapper: null

      constructor: (@scope, @id)->
        super

        @scope.settings =
          cross: true
          movable: true
          zoom: false
          grid: 5
          minHeight: 100
          minWidth: 400
          keyboard:
            'delete':
              name: 'delete'
              callback: 'removeSelected'

        @keyboard()

      update: (cb)->
        @fadeIn()
        success =(data)=>
          @fadeOut()
          cb(data)

        error =(result)->
          Message result.data.status, result.data.message

        map = new MapResource(@serialize())
        map.$update success, error

      load: ()->
        success =(map)=>
          @deserialize(map)
        error =(result)->
          Message result.data.status, result.data.message

        map = new MapResource({id: @id})
        map.$showFull success, error

      remove: (cb)->
        $translate("Are you sure you want to remove this card?").then (text)=>
          return if !confirm text
          success =(data)=>
            cb(data)
          error =(result)->
            Message result.data.status, result.data.message
          MapResource.delete {id: @id}, success, error

      fadeIn: ()->
        return if !@wrapper
        @wrapper.find(".page-loader").fadeIn("fast")

      fadeOut: ()->
        return if !@wrapper
        @wrapper.find(".page-loader").fadeOut("fast")

      serialize: ()=>
        id: @id
        name: @name
        description: @description
        options: @options

      deserialize: (model)=>
        @id = model.id
        @name = model.name
        @description = model.description
        @created_at = model.created_at
        @update_at = model.update_at
        @options = angular.extend({}, mapSettings.default, model.options)
        @layers = []

        if model?.layers && model.layers.length != 0
          angular.forEach model.layers, (layer)=>
            @layers.push new MapLayer(@scope).deserialize(layer)

          @scope.current_layer = @layers[0]
#          @scope.current_element = @layers[0].elements[0]
#          @scope.current_element.selected = true if @scope.current_element

    mapConstructor
]