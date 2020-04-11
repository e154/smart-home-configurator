angular
.module('appServices')
.factory 'Device', ['$resource', ($resource) ->

  serialProperties =(device)->
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
          address: prop.address
      when 'zigbee2mqtt'
        properties =
          zigbee2mqtt_device_id: prop.zigbee2mqtt_device.id

    properties

  deserialProperties =(device)->
    prop = device.properties
    properties = {}
    switch device.type
      when 'zigbee2mqtt'
        properties =
          zigbee2mqtt_device_id: prop.zigbee2mqtt_device_id
          zigbee2mqtt_device:
            id: prop.zigbee2mqtt_device_id
      when 'modbus_tcp'
        properties =
          slave_id: prop.slave_id
          address_port: prop.address_port
      when 'modbus_rtu'
        properties =
          slave_id: prop.slave_id
          baud: prop.baud
          data_bits: prop.data_bits
          stop_bits: prop.stop_bits
          parity: prop.parity
          tty: prop.tty
          timeout: prop.timeout
      when 'smartbus'
        properties =
          baud: prop.baud
          timeout: prop.timeout
          sleep: prop.sleep
          stop_bits: prop.stop_bits
      when 'mqtt'
        properties =
          address: prop.address

    properties

  $resource '/api/v1/device/:id', {id: '@id'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data.properties = deserialProperties(data)
        data

    group:
      url: '/api/v1/device/group'
      method: 'GET'
      responseType: 'json'

    create:
      method: 'POST'
      responseType: 'json'
      transformRequest: (data) ->
        data.properties = serialProperties(data)
        result = angular.toJson(data);
        result
      transformResponse: (data) ->
        data.properties = deserialProperties(data)
        data

    update:
      method: 'PUT'
      responseType: 'json'
      transformRequest: (data) ->
        data.properties = serialProperties(data)
        result = angular.toJson(data);
        result
      transformResponse: (data) ->
        data.properties = deserialProperties(data)
        data

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
