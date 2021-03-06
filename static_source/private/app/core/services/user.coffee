angular
.module('appServices')
.factory 'User', ['$resource', ($resource) ->
  $resource '/api/v1/user/:id', {id: '@id'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        user = data
        user.full_name = "#{user.last_name} #{user.first_name}" if user.first_name && user.last_name || ""
        user

    create:
      method: 'POST'
      responseType: 'json'
      transformResponse: (data) ->
        data

    update_status:
      url: '/api/v1/user/:id/update_status'
      method: 'PUT'
      responseType: 'json'

    update:
      method: 'PUT'
      responseType: 'json'
      transformResponse: (data) ->
        data

    delete:
      method: 'DELETE'

    all:
      url: '/api/v1/users'
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.items || []
]
