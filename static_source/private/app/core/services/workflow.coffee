angular
.module('appServices')
.factory 'Workflow', ['$resource', ($resource) ->
  $resource '/api/v1/workflow/:id', {id: '@id', workflow_id: '@workflow_id'},
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
      url: '/api/v1/workflows'
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.items || []

    update_scenario:
      url: '/api/v1/workflow/:workflow_id/update_scenario'
      method: 'PUT'

    scenario_show:
      url: '/api/v1/workflow/:workflow_id/scenario/:id'
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        data?.scenario || data

    scenario_create:
      url: '/api/v1/workflow/:workflow_id/scenario'
      method: 'POST'
      responseType: 'json'
      transformResponse: (data) ->
        data?.scenario || data

    scenario_update:
      url: '/api/v1/workflow/:workflow_id/scenario/:id'
      method: 'PUT'

    scenario_delete:
      url: '/api/v1/workflow/:workflow_id/scenario/:id'
      method: 'DELETE'

    get_scenarios:
      url: '/api/v1/workflow/:workflow_id/scenarios'
      method: 'GET'
      responseType: 'json'
      isArray: true
      transformResponse: (data) ->
        data?.scenarios || []

]
