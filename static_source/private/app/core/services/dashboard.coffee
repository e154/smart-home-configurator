angular
.module('appServices')
.factory 'Dashboard', ['$resource', ($resource) ->
  $resource '/api/v1/dashboard/:id', {id: '@id'},
    show:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        dashboard = data?.dashboard || data
#        console.log dashboard.widgets
        dashboard.widgets = angular.fromJson(dashboard.widgets || "[]") || []
        dashboard

    create:
      method: 'POST'
      responseType: 'json'
      transformRequest: (data)->
        data.widgets = angular.fromJson(data.widgets)
        result = angular.toJson(data);
        result

    update:
        method: 'PUT'
        responseType: 'json'
        transformRequest: (data)->
          data.widgets = angular.fromJson(data.widgets)
          result = angular.toJson(data);
          result

    delete:
      method: 'DELETE'

    all:
      method: 'GET'
      responseType: 'json'
      transformResponse: (data) ->
        meta: data?.meta || {}
        items: data?.dashboards || []
]
