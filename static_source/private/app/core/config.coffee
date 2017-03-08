angular
.module('app')
.config ['$translatePartialLoaderProvider', '$translateProvider', '$locationProvider', '$routeProvider', 'pikadayConfigProvider'
($translatePartialLoaderProvider, $translateProvider, $locationProvider, $routeProvider, pikadayConfigProvider) ->

  $translatePartialLoaderProvider.addPart('dashboard');

  $translateProvider.useLoader('$translatePartialLoader', {
    urlTemplate: '/static/translates/{part}/{lang}.json'
    loadFailureHandler: 'LocaleErrorHandler'
  })

  $translateProvider.preferredLanguage 'ru'
  $translateProvider.useSanitizeValueStrategy null

  $locationProvider.html5Mode
    enabled: true
    requireBase: false

  $routeProvider.otherwise
    redirectTo: '/'

#   Pikaday
    locales =
      ru:
        previousMonth : 'Назад',
        nextMonth     : 'Следующий',
        months        : ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентабрь", "Октябрь", "Ноябрь", "Декабрь"],
        weekdays      : ["Понедельник", "Вторник", "Среда","Четверг", "Пятница", "Суббота", "Воскресенье"],
        weekdaysShort : ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]


  pikadayConfigProvider.setConfig
    i18n: locales.ru
    locales: locales
    theme: 'smart-theme'

]

angular
.module('app')
.run ['$rootScope', '$state', 'storage', 'authForm', '$http'
($rootScope, $state, storage, authForm, $http) ->
  $rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
    document.getElementsByTagName('body')[0].classList.remove('loading')

#    http://stackoverflow.com/questions/24764764/conditionally-set-angulars-ng-class-based-on-state
  $rootScope.$state = $state
  $rootScope.server_url = window.app_settings.server_url

  $http.defaults.headers.common['access_token'] = window.app_settings.access_token

  #
  # themes:
  # dawn|clouds_midnight|tomorrow_night
  #
  $rootScope.ace_options =
    readOnly: false
    useWrapMode: true
    mode:'coffee'
    theme:'dawn'
    advanced:{}
    workerPath:'/static/js/ace-builds/src-noconflict'

  return
]