
'use strict'

### App Module ###

angular.module('templates', [])
angular.module('appDirectives', [])
angular.module('appFilters', [])
angular.module('appControllers', [])
angular.module('appServices', ['ngResource'])
app = angular.module('app', [
  'templates'
  'appDirectives'
  'appControllers'
  'appFilters'
  'appServices'
  'ngRoute'
  'ui.router'
  'base64'
])