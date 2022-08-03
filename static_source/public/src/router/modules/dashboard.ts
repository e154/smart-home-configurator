import { RouteConfig } from 'vue-router'
import Develop from '@/layout/develop.vue'

const dashboardsRouter: RouteConfig = {
  path: '/dashboards',
  component: Develop,
  redirect: '/dashboards/list',
  name: 'dashboards',
  meta: {
    title: 'dashboards',
    icon: 'table',
    alwaysShow: false
  },
  children: [
    {
      path: 'list',
      component: () => import('@/views/dashboard/index.vue'),
      name: 'dashboard list',
      meta: {
        title: 'dashboardList',
        icon: 'entity1'
      }
    },
    {
      path: 'edit/:id',
      component: () => import('@/views/dashboard/editor.vue'),
      props: true,
      name: 'dashboard edit',
      meta: {
        title: 'dashboardEdit',
        hidden: true
      }
    },
    {
      path: 'view/:id',
      component: () => import('@/views/dashboard/view.vue'),
      props: true,
      name: 'dashboard edit',
      meta: {
        title: 'dashboardEdit',
        hidden: true
      }
    }
  ]
}

export default dashboardsRouter
