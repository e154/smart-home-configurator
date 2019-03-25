angular
.module('angular-map')
.factory 'MapElement', ['$rootScope', '$compile', 'MapElementResource', 'Message'
'Notify', 'MapImage', 'MapDevice', 'MapScript', 'MapText', '$translate'
  ($rootScope, $compile, MapElementResource, Message, Notify, MapImage, MapDevice, MapScript,
  MapText, $translate) ->
    class MapElement

      scope: null

      prototype: null
      old_prototype: null

      current_tab: 'base'
      id: null
      layer_id: null
      map_id: null
      name: 'New item'
      description: ''
      prototype_type: ''
      prototype_id: null
      prototype: null
      status: 'enabled'
      selected: false
      created_at: null
      updated_at: null
      weight: 0
      graph_settings:
        width: null
        height: null
        position:
          top: 0
          left: 0

      constructor: (@scope, @layer_id)->
        @scope.$watch(()=>
            @prototype_type
        , (val, old_val)=>
          return if val == old_val
          @get_prototype()
        )
        @get_prototype()

      resetPosition: ()->
        @graph_settings.position =
          top: 0
          left: 0

      inheritPosition: ()->
        position = $(".map-editor").position()
        @graph_settings.position =
          top: parseInt(position.top, 10) * -1
          left: parseInt(position.left, 10) * -1

      serialize: ()->
        prototype = @prototype?.serialize() || null
        name: @name
        id: @id if @id
        map_id: @map_id if @map_id
        layer_id: @layer_id if @layer_id
        status: @status
        description: @description
        created_at: @created_at if @created_at
        updated_at: @updated_at if @updated_at
        weight: @weight
        prototype_type: @prototype_type
        prototype_id: @prototype_id if @prototype_id
        graph_settings: @graph_settings
        prototype: prototype if prototype

      deserialize: (element)->
        @id = element.id || null
        @map_id = element.map_id if element.map_id
        @layer_id = element.layer_id if element.layer_id
        @name = element.name || ''
        @description = element.description || ''
        @status = element.status || ''
        @prototype_type = element.prototype_type || ''
        @prototype_id = element.prototype_id if element.prototype_id
        @weight = element.weight || 0
        @created_at = element.created_at || ''
        @updated_at = element.updated_at || ''
        @graph_settings = element.graph_settings

        if element.prototype
          @get_prototype(element.prototype)

        return @

      create: (cb)->
        success =(data)=>
          @deserialize(data)
          Notify 'success', 'Item successfully created', 3
          cb() if cb
        error =(result)->
          Message result.data.status, result.data.message

        model = new MapElementResource(@serialize())
        model.$create success, error

      update_element_only: (cb)->
        update: (cb)->
        success =(data)=>
          cb() if cb
        error =(result)->
          Message result.data.status, result.data.message

        model = new MapElementResource(@serialize())
        model.$update_element_only success, error

      update: (cb)->
        console.log '---', @
        success =(data)=>
          Notify 'success', 'Item successfully updated', 3
          cb() if cb
        error =(result)->
          Message result.data.status, result.data.message

        model = new MapElementResource(@serialize())
        model.$update success, error

      remove: (cb)->
        $translate('Are you sure you want to delete this item?').then (text)=>
          return if !confirm text
          success =(data)=>
            cb() if cb
            Notify 'success', 'Item successfully deleted', 3
          error =(result)->
            Message result.data.status, result.data.message

          model = new MapElementResource({id: @id})
          model.$delete success, error

      get_prototype: (data)->
        switch @prototype_type
          when 'text'
            @prototype = new MapText(@scope)
          when 'image'
            @prototype = new MapImage(@scope)
          when 'device'
            @prototype = new MapDevice(@scope)
          when 'script'
            @prototype = new MapScript(@scope)

        if data && data.system_name
          @prototype.deserialize(data)

      copy: (_element)->
        @deserialize(_element.serialize())
        @id = null
        @prototype_id = null
        @name = "#{@name} (copy)" if @name.indexOf('(copy)') == -1

        @

      valid: ()->
        return false if !@prototype
        @prototype.valid()

    MapElement
]