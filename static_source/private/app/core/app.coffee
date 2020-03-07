
'use strict'

### App Module ###

angular.module('templates', [])
angular.module('appDirectives', [])
angular.module('appFilters', [])
angular.module('appControllers', [])
angular.module('appConstants', [])
angular.module('appServices', ['ngResource'])
app = angular.module('app', [
  'pascalprecht.translate'
  'templates'
  'appDirectives'
  'ngRoute'
  'appControllers'
  'appConstants'
  'appFilters'
  'appServices'
  'ui.router'
  'toaster'
  'angular-bpmn'
  'ui.select'
  'ngSanitize'
  'ngDialog'
  'ui.bootstrap.pagination'
  'pikaday'
  'ui.tree'
  'angular-map'
  'ng-sortable'
  'ngFileUpload'
  'ngDragDrop'
  'gridster'
  'passwordCheck'
  'http-auth-interceptor'
  'base64',
  'monospaced.qrcode',
  'ngTagsInput'
])

app.version = window.app_settings.info
app.access_token = window.app_settings.access_token
app.current_user = window.app_settings.current_user
app.debug = window.app_settings.debug
app.language = window.app_settings.language
app.server_url = window.app_settings.server_url
