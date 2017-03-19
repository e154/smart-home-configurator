angular
.module('appServices')
.factory 'Workflow', ['$resource', ($resource) ->
  $resource window.app_settings.server_url + '/api/v1/workflow/:id', {id: '@id', workflow_id: '@workflow_id'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.workflow || data

    create:
      method: 'POST'
      responseType: 'json'

    update:
      method: 'PUT'

    delete:
      method: 'DELETE'

    all:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.workflows || []

    update_scenario:
      url: window.app_settings.server_url + '/api/v1/workflow/:workflow_id/update_scenario'
      method: 'PUT'

    scenario_show:
      url: window.app_settings.server_url + '/api/v1/workflow/:workflow_id/scenario/:id'
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.workflow_scenario || data

    scenario_create:
      url: window.app_settings.server_url + '/api/v1/workflow/:workflow_id/scenario'
      method: 'POST'
      responseType: 'json'
      transformResponse: (data) ->
        data?.workflow_scenario || data

    scenario_update:
      url: window.app_settings.server_url + '/api/v1/workflow/:workflow_id/scenario/:id'
      method: 'PUT'

    scenario_delete:
      url: window.app_settings.server_url + '/api/v1/workflow/:workflow_id/scenario/:id'
      method: 'DELETE'

    scenario_all:
      url: window.app_settings.server_url + '/api/v1/workflow/:workflow_id/scenarios'
      method: 'GET'
      responseType: 'json'
      isArray: true
      transformResponse: (data) ->
        data?.workflow_scenarios || []

]
