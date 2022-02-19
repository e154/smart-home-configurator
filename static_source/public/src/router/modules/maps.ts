import { RouteConfig } from 'vue-router'
import Develop from '@/layout/develop.vue'

const mapsRouter: RouteConfig = {
  path: '/maps',
  component: Develop,
  redirect: '/maps/list',
  name: 'maps',
  meta: {
    title: 'maps',
    icon: 'table',
    alwaysShow: true
  },
  children: [
    {
      path: 'list',
      component: () => import('@/views/maps/index.vue'),
      name: 'map list',
      meta: {
        title: 'mapList',
        }
    },
  ]
}

export default mapsRouter
