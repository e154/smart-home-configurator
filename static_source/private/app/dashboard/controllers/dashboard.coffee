angular
.module('appControllers')
.controller 'dashboardCtrl', ['$scope', 'Stream' ,'authForm', 'ifCan'
($scope, Stream, authForm, ifCan) ->
  vm = this

  vm.mainMenu =
    'name': 'Main Menu'
    'items': [
      {
        'label': 'dashboard.name'
        'route': 'dashboard.index'
        'icon': 'fa fa-home'
        'access': {dashboard: ['read']}
      }
      {
        'label': 'Account'
        'route': 'dashboard.account'
        'icon': 'fa fa-user'
        'items': [
          {
            'label': 'Sign out'
            'route': 'dashboard.signout'
            'access': {user: ['read']}
          }
        ]
        'access': {user: ['read']}
      }
      {
        'label': 'Maps'
        'route': 'dashboard.map'
        'link': 'dashboard.map.index'
        'icon': 'fa fa-map-o'
        'items': [
          {
            'label': 'All maps'
            'route': 'dashboard.map.index'
            'access': {map: ['read_map']}
          }
          {
            'label': 'Add new'
            'route': 'dashboard.map.new'
            'access': {map: ['create_map']}
          }
        ]
        'access': {map: ['read_map']}
      }
      {
        'label': 'Settings'
        'route': 'dashboard.menu'
        'link': 'dashboard.menu'
        'icon': 'fa fa-cogs'
        'access': {dashboard: ['read']}
      }
    ]

  vm.secondMenu =
    'name': 'Second Menu'
    'items': [
      {
        'id': 1
        'col': 0
        'row': 0
        'sizeY': 1
        'sizeX': 1
        'label': 'Devices'
        'route': 'dashboard.device'
        'link': 'dashboard.device.index'
        'icon': 'fa fa-microchip'
        'items': [
          {
            'label': 'All device'
            'route': 'dashboard.device.index'
            'access': {device: ['read']}
          }
          {
            'label': 'Add new'
            'route': 'dashboard.device.new'
            'access': {device: ['create']}
          }
        ]
        'access': {device: ['read']}
      }
      {
        'id': 2
        'col': 1
        'row': 0
        'sizeY': 1
        'sizeX': 1
        'label': 'Nodes'
        'route': 'dashboard.node'
        'link': 'dashboard.node.index'
        'icon': 'fa fa-sitemap'
        'items': [
          {
            'label': 'All nodes'
            'route': 'dashboard.node.index'
            'access': {node: ['read']}
          }
          {
            'label': 'Add new'
            'route': 'dashboard.node.new'
            'access': {node: ['create']}
          }
        ]
        'access': {node: ['read']}
      }
      {
        'id': 3
        'col': 2
        'row': 0
        'sizeY': 1
        'sizeX': 1
        'label': 'Flows'
        'route': 'dashboard.flow'
        'link': 'dashboard.flow.index'
        'icon': 'bpmn-icon-business-rule'
        'items': [
          {
            'label': 'All flow'
            'route': 'dashboard.flow.index'
            'access': {flow: ['read']}
          }
          {
            'label': 'Add new'
            'route': 'dashboard.flow.new'
            'access': {flow: ['create']}
          }
        ]
        'access': {flow: ['read']}
      }
      {
        'id': 4
        'col': 3
        'row': 0
        'sizeY': 1
        'sizeX': 1
        'label': 'Workflow'
        'route': 'dashboard.workflow'
        'link': 'dashboard.workflow.index'
        'icon': 'fa fa-cube'
        'items': [
          {
            'label': 'All workflow'
            'route': 'dashboard.workflow.index'
            'access': {workflow: ['read']}
          }
          {
            'label': 'Add new'
            'route': 'dashboard.workflow.new'
            'access': {workflow: ['create']}
          }
        ]
        'access': {workflow: ['read']}
      }
      {
        'id': 5
        'col': 4
        'row': 0
        'sizeY': 1
        'sizeX': 1
        'label': 'Scripts'
        'route': 'dashboard.script'
        'link': 'dashboard.script.index'
        'icon': 'fa fa-pencil-square-o'
        'items': [
          {
            'label': 'All scripts'
            'route': 'dashboard.script.index'
            'access': {script: ['read']}
          }
          {
            'label': 'Add new'
            'route': 'dashboard.script.new'
            'access': {script: ['create']}
          }
        ]
        'access': {script: ['read']}
      }
      {
        'id': 6
        'col': 0
        'row': 1
        'sizeY': 1
        'sizeX': 1
        'label': 'Mqtt'
        'route': 'dashboard.mqtt.index'
        'icon': 'fa fa-tree'
        'access': {mqtt: ['read']}
        'items': [
          {
            'label': 'All clients'
            'route': 'dashboard.mqtt.index'
          }
          {
            'label': 'Publish message'
            'route': 'dashboard.mqtt.publish'
            'access': {mqtt: ['publish']}
          }
        ]
      }
      {
        'id': 7
        'col': 3
        'row': 1
        'sizeY': 1
        'sizeX': 1
        'label': 'Logs'
        'route': 'dashboard.log.index'
        'icon': 'fa fa-file-text-o'
        'access': {log: ['read']}

      }
      {
        'id': 8
        'col': 2
        'row': 1
        'sizeY': 2
        'sizeX': 1

        'label': 'Notifr'
        'link': 'dashboard.notifr.index'
        'route': 'dashboard.notifr.index'
        'icon': 'fa fa-envelope'
        'access': {notifr: ['read']}
        'items': [
          {
            'label': 'New notify'
            'route': 'dashboard.notifr.new_notification'
            'access': {notifr: ['create_notify']}
          }
          {
            'label': 'All params'
            'route': 'dashboard.notifr.index'
          }
          {
            'label': 'All items'
            'route': 'dashboard.notifr.items'
            'access': {template: ['read']}
          }
          {
            'label': 'All templates'
            'route': 'dashboard.notifr.template_list'
            'access': {template: ['read']}
          }
          {
            'label': 'Add template'
            'route': 'dashboard.notifr.new_template'
            'access': {template: ['read', 'create']}
          }
          {
            'label': 'Settings'
            'route': 'dashboard.notifr.settings'
            'access': {notifr: ['read_config', 'update_config']}
          }
        ]
      }
      {
        'id': 9
        'col': 1
        'row': 1
        'sizeY': 2
        'sizeX': 1
        'label': 'Users'
        'link': 'dashboard.user.index'
        'route': 'dashboard.user'
        'icon': 'fa fa-users'
        'items': [
          {
            'label': 'All users'
            'route': 'dashboard.user.index'
            'access': {user: ['read']}
          }
          {
            'label': 'All roles'
            'route': 'dashboard.role.index'
            'access': {user: ['read_role']}
          }
          {
            'label': 'Add user'
            'route': 'dashboard.user.new'
            'access': {user: ['create']}
          }
          {
            'label': 'Add role'
            'route': 'dashboard.role.new'
            'access': {user: ['create_role']}
          }
          {
            'label': 'Permissions'
            'route': 'dashboard.permissions'
            'access': {user: ['read']}
          }
        ]
        'access': {user: ['read']}
      }
      {
        'id': 10
        'col': 4
        'row': 1
        'sizeY': 1
        'sizeX': 1
        'label': 'Gate'
        'route': 'dashboard.gate.index'
        'icon': 'fa fa-cloud'
        'access': {gate: ['read']}

      }
      {
        'id': 10
        'col': 0
        'row': 2
        'sizeY': 1
        'sizeX': 1
        'label': 'Swagger'
        'route': 'dashboard.swagger.index'
        'icon': 'fa fa-file-text-o'
        'access': {swagger: ['read']}

      }
    ]


  $scope.nodes = {}
  Stream.subscribe "nodes", (nodes)->
    $scope.nodes = nodes

  # show signin dialog
  if !app_settings.current_user.id
    authForm.show()

  vm
]