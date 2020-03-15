#
#
# signature:
# Stream.send(object)
#
# promise = Stream.sendRequest(command, value)
# promise.then (result)->
#   $log.debug result
#
# example:
# Stream.send "request", {value: "qw"}
#
# Stream.sendRequest("request", {value: "qw"}).then (result)->
#   $log.debug result
#
#

angular
.module('appServices')
.service 'Stream', [ '$q', '$log', 'Notify', 'uuid', '$rootScope', '$timeout'
($q, $log, Notify, uuid, $rootScope, $timeout) ->
  class Stream
    socket: null
    callbacks: null
    subscribers: null
    t: ''

    constructor: (t)->
      @subscribers = {}
      @callbacks = {}
      @connect(t)

    connect: (t)->

      return if @socket

      #TODO remove
#      return
      @t = t

      protocol = if location.protocol == 'https:' then 'wss' else 'ws'
      url = "#{protocol}://#{window.location.host}/api/v1/ws?access_token=#{app.access_token}"

      @socket = new WebSocket(url);
      @socket.onopen = @onopen
      @socket.onclose = @onclose
      @socket.onerror = ()=>
        @socket.close() if @socket
      @socket.onmessage = @onmessage

    setHandler: (event, callback)->
      @connect() if !@socket
      @socket.setHandler event, callback

    onmessage: (e)=>
      m = {type: ""}
      try
        m = angular.fromJson(e.data)
      catch
        $log.debug "from the stream came a string value"
        return

      switch m.type
        when "notify"
          Notify m.payload.type, m.payload.body
        when "broadcast"
          if (m.command in Object.keys(@subscribers))
            for own key, f of @subscribers[m.command]
              f(m.payload)

      if !m.id || m.id == "" || m.id == "00000000-0000-0000-0000-000000000000"
        return

      if @callbacks[m.id]?.defer
        $rootScope.$apply @callbacks[m.id].defer.resolve(m.payload)
        delete @callbacks[m.id]

      return

    onopen: ->
      clientInfo =->
        n = navigator

        width: window.screen.width
        height: window.screen.height
        cookie: n.cookieEnabled
        language: n.language
        platform: n.platform
#        plugins: n.plugins
        location: window.location.pathname
        href: window.location.href

      @send angular.toJson({client_info: {value: clientInfo()}})

    onclose: =>
      $timeout ()=>
        @socket = null
        @connect(@t)
      , 1000

    send: (m)->
      if typeof m != 'object'
        return

      @socket.send angular.toJson(m)

    sendRequest: (c, m)=>
      if typeof m != 'object'
        return

      defer = $q.defer()
      id = uuid.getId()
      @callbacks[id] =
        time: new Date()
        defer: defer

      $timeout ()=>
        q = {
          id: id
          command: c
          payload: m
        }
        @send q

      defer.promise

    subscribe: (name, id, func)=>
      if !(name in @subscribers)
        @subscribers[name] = {}
      @subscribers[name][id] = func

    unsubscribe: (name, id)->
      if (name in @subscribers)
        if (id in @subscribers[id])
          delete @subscribers[name][id]


  new Stream('websock')
]
