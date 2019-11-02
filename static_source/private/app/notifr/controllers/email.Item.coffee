angular
.module('appControllers')
.controller 'emailItemCtrl', ['$scope','Message','EmailItem','Notify','$rootScope', '$translate'
($scope, Message, EmailItem, Notify, $rootScope, $translate) ->

  vm = this
  vm.items = []
  vm.tree = []
  vm.totalItems = 0
  vm.activeItem =
    name: ""
    description: ""
    content: ""
  vm.isNew = true

  $scope.ace_options = angular.extend $rootScope.ace_options, {mode: null}

  vm.getItem = (item) ->
    success =(item) ->
      vm.activeItem = item
    error =(response)->
      Message response.data.status, response.data.message

    EmailItem.show {name: item}, success, error

  vm.getTree = ->

    success =(tree) ->
      vm.tree = []
      vm.tree.push tree
    error =(response)->
      Message response.data.status, response.data.message

    EmailItem.get_tree {}, success, error

  vm.updateTree = ->
    success =(data) ->
      Notify 'success', 'Tree successfully updated', 3
    error =(response)->
      Message response.data.status, response.data.message

    EmailItem.update_tree {}, vm.tree, success, error

  vm.edit = (name) ->
    vm.isNew = false
    vm.getItem name
    return

  vm.addNew = ->
    vm.isNew = true
    vm.activeItem =
      name: ''
      description: ''
      content: ''
      status: 'inactive'
      parent: 'main'
    return

  vm.save = ->
    success =(data) ->
      Notify 'success', 'Item successfully created', 3
      vm.isNew = false
      vm.getTree()

    error =(response)->
      Message response.data.status, response.data.message

    EmailItem.create {}, vm.activeItem, success, error

  vm.update = ->

    success =->
      vm.getTree()
      Notify 'success', 'Item successfully updated', 3

    error =(response)->
      Message response.data.status, response.data.message

    EmailItem.update {name: vm.activeItem.name}, vm.activeItem, success, error

  vm.delete = ->
    success =->
      vm.getTree()
      vm.addNew()
      Notify 'success', 'Item successfully deleted', 3

    error =(response)->
      Message response.data.status, response.data.message

    if confirm('delete the template element?')
      EmailItem.delete {name: vm.activeItem.name}, vm.activeItem, success, error

  vm.toggleStatus = (item) ->
    success =->
      vm.getTree()
    error =(response)->
      Message response.data.status, response.data.message

    item.status = if item.status == 'active' then 'inactive' else 'active'
    EmailItem.update_status {name: item.name}, {name: item.name, status: item.status}, success, error

  #init
  vm.getTree()
  vm.addNew()

  vm
]
