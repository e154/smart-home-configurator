angular
.module('appControllers')
.controller 'notifrIndexCtrl', ['$scope', 'Notifr','ngDialog'
($scope, Notifr, ngDialog) ->

  tableCallback = {}
  $scope.options =
    perPage: 20
    resource: Notifr
    columns: [
      {
        name: 'notifr.refresh'
        field: 'state'
        template: "<button class='btn btn-success btn-xs' ng-if='item[field] == \"error\"'><i class='fa fa-refresh'> refresh</i></button>"
        width: '100px'
        clickCallback: ($event, item)->
          $event.preventDefault()
          $event.stopPropagation()

          false
      }
      {
        name: 'notifr.title'
        field: 'message'
        template: "<span truncate-text='100'>{{item[field].email_title || item[field].sma_text || item[field].ui_title}}</span>"
      }
      {
        name: 'notifr.state'
        field: 'state'
        template: "<span class='label' ng-class='{\"label-success\": item[field] == \"succeed\", \"label-danger\": item[field] == \"error\", \"label-default\": item[field] == \"in_process\"}'>{{item[field]}}</span>"
        width: '100px'
      }
      {
        name: 'notifr.type'
        field: 'message'
        template: "<span class='label' ng-class='{\"label-email\": item[field].type == \"email\", \"label-push\": item[field].type == \"push\", \"label-sms\": item[field].type == \"sms\"}'>{{item[field].type}}</span>"
        width: '100px'
      }
      {
        name: 'notifr.address'
        field: 'address'
        width: '160px'
      }
      {
        name: 'notifr.created_at'
        field: 'created_at'
        width: '160px'
        template: '<span>{{item[field] | readableDateTime}}</span>'
      }
      {
        name: 'notifr.updated_at'
        field: 'update_at'
        width: '160px'
        template: '<span>{{item[field] | readableDateTime}}</span>'
      }
    ]
    menu: null
    callback: tableCallback
    rowsClickCallback: ($event, item)->
      $event.preventDefault()

      $scope.notify = item
      
      ngDialog.open
        scope: $scope
        showClose: false
        closeByEscape: true
        closeByDocument: true
        template: '/notifr/templates/modal.show.html'
        className: 'ngdialog-theme-default ngdialog-notifr-show'
        controller: 'notifrShowCtrl'

      false

  $scope.update =->
    tableCallback.update()

  $scope.new_notification =->
    ngDialog.open
      scope: $scope
      showClose: false
      closeByEscape: false
      closeByDocument: false
      template: '/notifr/templates/modal.new.html'
      className: 'ngdialog-theme-default ngdialog-notifr-show'
      controller: 'notifrNewCtrl'
]
