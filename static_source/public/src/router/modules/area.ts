import { RouteConfig } from 'vue-router'
import Develop from '@/layout/develop.vue'

const areasRouter: RouteConfig = {
  path: '/areas',
  component: Develop,
  redirect: '/areas/list',
  name: 'areas',
  meta: {
    title: 'areas',
    icon: 'table',
    alwaysShow: true
  },
  children: [
    {
      path: 'list',
      component: () => import('@/views/areas/index.vue'),
      name: 'area list',
      meta: {
        title: 'areaList',
        }
    },
    {
      path: 'edit/:id',
      component: () => import('@/views/areas/edit.vue'),
      props: true,
      name: 'area edit',
      meta: {
        title: 'areaEdit',
        hidden: true
      }
    },
    {
      path: 'new',
      component: () => import('@/views/areas/new.vue'),
      props: true,
      name: 'area new',
      meta: {
        title: 'areaNew',
      }
    },
  ]
}

export default areasRouter
