angular
.module("appServices")
.service 'Notify', ['$log', 'toaster', '$translate'
($log, toaster, $translate) ->
  (status, message, time)->
    if !message || typeof message != 'string' || message == ""
      return

    $translate(message).then (message)->

      if !time
        time = 5

      time *= 1000

      toaster.pop(status, null, message, time, 'trustedHtml')
]