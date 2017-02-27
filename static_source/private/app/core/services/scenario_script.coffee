angular
.module('appServices')
.factory 'ScenarioScript', ['$resource', ($resource) ->
  $resource window.app_settings.server_url + '/api/v1/scenario_script/:id', {id: '@id'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.scenario_script || data

    create:
      method: 'POST'
      responseType: 'json'
      transformResponse: (data) ->
        data?.scenario_script || data

    update:
        method: 'PUT'
        responseType: 'json'
        transformResponse: (data) ->
          data?.scenario_script || data

    delete:
      method: 'DELETE'

    all:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.scenario_scripts || []
]
