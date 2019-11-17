angular.module('appConstants')
.factory 'DeviceTypes', ['$http', ($http)->
  [
    'default'
    'smartbus'
    'modbus_rtu'
    'modbus_tcp'
    'command'
  ]
]