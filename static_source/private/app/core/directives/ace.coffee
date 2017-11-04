

angular
.module('appDirectives')
.constant('uiAceConfig', {})
.directive 'uiAce', ['uiAceConfig', (uiAceConfig) ->
  if angular.isUndefined(window.ace)
    throw new Error('ui-ace need ace to work... (o rly?)')

  setOptions = (acee, session, opts) ->

    # sets the ace worker path, if running from concatenated
    # or minified source
    if angular.isDefined(opts.workerPath)
      config = window.ace.require('ace/config')
      config.set 'workerPath', opts.workerPath
      config.set 'modePath', opts.modePath
      config.set 'basePath', opts.basePath
      config.set 'themePath', opts.themePath

    # ace requires loading
    if angular.isDefined(opts.require)
      opts.require.forEach (n) ->
        window.ace.require n
        return
    # Boolean options
    if angular.isDefined(opts.showGutter)
      acee.renderer.setShowGutter opts.showGutter
    if angular.isDefined(opts.useWrapMode)
      session.setUseWrapMode opts.useWrapMode
    if angular.isDefined(opts.showInvisibles)
      acee.renderer.setShowInvisibles opts.showInvisibles
    if angular.isDefined(opts.showIndentGuides)
      acee.renderer.setDisplayIndentGuides opts.showIndentGuides
    if angular.isDefined(opts.useSoftTabs)
      session.setUseSoftTabs opts.useSoftTabs
    if angular.isDefined(opts.showPrintMargin)
      acee.setShowPrintMargin opts.showPrintMargin
    # commands
    if angular.isDefined(opts.disableSearch) and opts.disableSearch
      acee.commands.addCommands [ {
        name: 'unfind'
        bindKey:
          win: 'Ctrl-F'
          mac: 'Command-F'
        exec: ->
          false
        readOnly: true
      } ]
    # Basic options
    if angular.isString(opts.theme)
      acee.setTheme 'ace/theme/' + opts.theme
    if angular.isString(opts.mode)
      session.setMode 'ace/mode/' + opts.mode
    # Advanced options
    if angular.isDefined(opts.firstLineNumber)
      if angular.isNumber(opts.firstLineNumber)
        session.setOption 'firstLineNumber', opts.firstLineNumber
      else if angular.isFunction(opts.firstLineNumber)
        session.setOption 'firstLineNumber', opts.firstLineNumber()
    # advanced options
    key = undefined
    obj = undefined
    if angular.isDefined(opts.advanced)
      for key of opts.advanced
        `key = key`
        # create a javascript object with the key and value
        obj =
          name: key
          value: opts.advanced[key]
        # try to assign the option to the ace editor
        acee.setOption obj.name, obj.value
    # advanced options for the renderer
    if angular.isDefined(opts.rendererOptions)
      for key of opts.rendererOptions
        `key = key`
        # create a javascript object with the key and value
        obj =
          name: key
          value: opts.rendererOptions[key]
        # try to assign the option to the ace editor
        acee.renderer.setOption obj.name, obj.value
    # onLoad callbacks
    angular.forEach opts.callbacks, (cb) ->
      if angular.isFunction(cb)
        cb acee
      return
    return

  {
    restrict: 'EA'
    require: '?ngModel'
    link: (scope, elm, attrs, ngModel) ->

      ###*
      # Corresponds the uiAceConfig ACE configuration.
      # @type object
      ###

      options = uiAceConfig.ace or {}

      ###*
      # uiAceConfig merged with user options via json in attribute or data binding
      # @type object
      ###

      opts = angular.extend({}, options, scope.$eval(attrs.uiAce))

      ###*
      # ACE editor
      # @type object
      ###

      acee = window.ace.edit(elm[0])

      ###*
      # ACE editor session.
      # @type object
      # @see [EditSession]{@link http://ace.c9.io/#nav=api&api=edit_session}
      ###

      session = acee.getSession()

      ###*
      # Reference to a change listener created by the listener factory.
      # @function
      # @see listenerFactory.onChange
      ###

      onChangeListener = undefined

      ###*
      # Reference to a blur listener created by the listener factory.
      # @function
      # @see listenerFactory.onBlur
      ###

      onBlurListener = undefined

      ###*
      # Calls a callback by checking its existing. The argument list
      # is variable and thus this function is relying on the arguments
      # object.
      # @throws {Error} If the callback isn't a function
      ###

      executeUserCallback = ->

        ###*
        # The callback function grabbed from the array-like arguments
        # object. The first argument should always be the callback.
        #
        # @see [arguments]{@link https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions_and_function_scope/arguments}
        # @type {*}
        ###

        callback = arguments[0]

        ###*
        # Arguments to be passed to the callback. These are taken
        # from the array-like arguments object. The first argument
        # is stripped because that should be the callback function.
        #
        # @see [arguments]{@link https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions_and_function_scope/arguments}
        # @type {Array}
        ###

        args = Array::slice.call(arguments, 1)
        if angular.isDefined(callback)
          scope.$evalAsync ->
            if angular.isFunction(callback)
              callback args
            else
              throw new Error('ui-ace use a function as callback.')
            return
        return

      ###*
      # Listener factory. Until now only change listeners can be created.
      # @type object
      ###

      listenerFactory =
        onChange: (callback) ->
          (e) ->
            newValue = session.getValue()
            if ngModel and newValue != ngModel.$viewValue and !scope.$$phase and !scope.$root.$$phase
              scope.$evalAsync ->
                ngModel.$setViewValue newValue
                return
            executeUserCallback callback, e, acee
            return
        onBlur: (callback) ->
          ->
            executeUserCallback callback, acee
            return
      attrs.$observe 'readonly', (value) ->
        acee.setReadOnly ! !value or value == ''
        return
      # Value Blind
      if ngModel
        ngModel.$formatters.push (value) ->
          if angular.isUndefined(value) or value == null
            return ''
          else if angular.isObject(value) or angular.isArray(value)
            throw new Error('ui-ace cannot use an object or an array as a model')
          value

        ngModel.$render = ->
          session.setValue ngModel.$viewValue
          return

      # Listen for option updates

      updateOptions = (current, previous) ->
        if current == previous
          return
        opts = angular.extend({}, options, scope.$eval(attrs.uiAce))
        opts.callbacks = [ opts.onLoad ]
        if opts.onLoad != options.onLoad
          # also call the global onLoad handler
          opts.callbacks.unshift options.onLoad
        # EVENTS
        # unbind old change listener
        session.removeListener 'change', onChangeListener
        # bind new change listener
        onChangeListener = listenerFactory.onChange(opts.onChange)
        session.on 'change', onChangeListener
        # unbind old blur listener
        #session.removeListener('blur', onBlurListener);
        acee.removeListener 'blur', onBlurListener
        # bind new blur listener
        onBlurListener = listenerFactory.onBlur(opts.onBlur)
        acee.on 'blur', onBlurListener
        setOptions acee, session, opts
        return

      scope.$watch attrs.uiAce, updateOptions, true
      # set the options here, even if we try to watch later, if this
      # line is missing things go wrong (and the tests will also fail)
      updateOptions options
      elm.on '$destroy', ->
        acee.session.$stopWorker()
        acee.destroy()
        return
      scope.$watch (->
        [
          elm[0].offsetWidth
          elm[0].offsetHeight
        ]
      ), (->
        acee.resize()
        acee.renderer.updateFull()
        return
      ), true
      return

  }
]
