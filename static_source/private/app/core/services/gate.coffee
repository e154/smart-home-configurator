angular
.module('appServices')
.factory 'Gate', ['$resource', ($resource) ->
  $resource '/api/v1/gate/:id', {id: '@id'},
    getSettings:
      url: '/api/v1/gate'
      method: 'GET'
      responseType: 'json'

    updateSettings:
      url: '/api/v1/gate'
      method: 'PUT'

    getMobileList:
      url: '/api/v1/gate/mobiles'
      method: 'GET'
      responseType: 'json'

    addMobile:
      url: '/api/v1/gate/mobile'
      method: 'POST'
      responseType: 'json'

    deleteMobile:
      url: '/api/v1/gate/mobile/:token'
      method: 'DELETE'
]