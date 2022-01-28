import { RouteConfig } from 'vue-router'
import Layout from '@/layout/index.vue'

const zigbee2mqttRouter: RouteConfig = {
  path: '/zigbee2mqtt',
  component: Layout,
  redirect: '/zigbee2mqtt/list',
  name: 'zigbee2mqtt',
  meta: {
    title: 'zigbee2mqtt',
    icon: 'table',
    alwaysShow: true
  },
  children: [
    {
      path: 'list',
      component: () => import('@/smart-home/zigbee2mqtt/index.vue'),
      name: 'bridge list',
      meta: {
        title: 'bridgeList',
        }
    },
    {
      path: 'edit/:id',
      component: () => import('@/smart-home/zigbee2mqtt/edit.vue'),
      props: true,
      name: 'bridge edit',
      meta: {
        title: 'bridgeEdit',
        hidden: true
      }
    },
    {
      path: 'new',
      component: () => import('@/smart-home/zigbee2mqtt/new.vue'),
      props: true,
      name: 'bridge new',
      meta: {
        title: 'bridgeNew',
      }
    },
  ]
}

export default zigbee2mqttRouter
