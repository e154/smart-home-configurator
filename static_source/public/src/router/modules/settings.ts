import { RouteConfig } from 'vue-router'
import Develop from '@/layout/develop.vue'

const settingsRouter: RouteConfig = {
  path: '/settings',
  component: Develop,
  redirect: '/settings/list',
  name: 'settings',
  meta: {},
  children: [
    {
      path: 'index',
      component: () => import('@/views/settings/index.vue'),
      name: 'settings',
      meta: {
        title: 'settings',
        icon: 'settings',
        noCache: true
      }
    }
  ]
}

export default settingsRouter
