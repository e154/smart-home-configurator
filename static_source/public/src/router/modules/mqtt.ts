import { RouteConfig } from 'vue-router'
import Develop from '@/layout/develop.vue'

const mqttRouter: RouteConfig = {
  path: '/mqtt',
  component: Develop,
  redirect: '/mqtt/index',
  name: 'mqtt',
  meta: { hidden: false },
  children: [
    {
      path: 'index',
      component: () => import('@/views/mqtt/index.vue'),
      name: 'mqtt list',
      meta: {
        title: 'mqtt',
        icon: 'table',
        noCache: true
      }
    }
  ]
}

export default mqttRouter
