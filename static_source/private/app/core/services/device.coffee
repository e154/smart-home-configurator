angular
.module('appServices')
.factory 'Device', ['$resource', ($resource) ->

  getProperties =(device)->
    prop = device.properties
    properties = {}
    switch device.type
      when 'smartbus'
        properties =
          baud: prop.baud
          timeout: prop.timeout
          sleep: prop.sleep
          stop_bits: prop.stop_bits
          tty: prop.tty
      when 'modbus_rtu'
        properties =
          slave_id: prop.slave_id
          baud: prop.baud
          data_bits: prop.data_bits
          stop_bits: prop.stop_bits
          parity: prop.parity
          tty: prop.tty
          timeout: prop.timeout
      when 'modbus_tcp'
        properties =
          slave_id: prop.slave_id
          address_port: prop.address_port
      when 'command'
        properties = {}
      when 'mqtt'
        properties =
          user: prop.user
          password: prop.password

    properties

  $resource '/api/v1/device/:id', {id: '@id'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data

    group:
      url: '/api/v1/device/group'
      method: 'GET'
      responseType: 'json'

    create:
      method: 'POST'
      responseType: 'json'
      transformRequest: (data) ->
        data.properties = getProperties(data)
        result = angular.toJson(data);
        result

    update:
      method: 'PUT'
      responseType: 'json'
      transformRequest: (data) ->
        data.properties = getProperties(data)
        result = angular.toJson(data);
        result

    delete:
      method: 'DELETE'

    all:
      url: '/api/v1/devices'
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.items || []
]
