angular
.module('appServices')
.factory 'Auth', ['$resource', ($resource) ->
  $resource '/signin', {},
    recovery:
      url: '/recovery'
      method: 'POST'
      responseType: 'json'

    reset:
      url: '/reset'
      method: 'POST'
      responseType: 'json'
]
