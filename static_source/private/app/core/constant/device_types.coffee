angular.module('appConstants')
.factory 'DeviceTypes', ['$http', ($http)->
  [
    'default'
    'smartbus'
    'modbus'
    'command'
  ]
]