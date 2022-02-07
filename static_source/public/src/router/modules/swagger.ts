import { RouteConfig } from 'vue-router'
import Layout from '@/layout/index.vue'

const swaggerRouter: RouteConfig = {
  path: '/swagger',
  component: Layout,
  redirect: '/swagger/list',
  name: 'swagger',
  meta: {
    title: 'swagger',
    icon: 'table',
    alwaysShow: true
  },
  children: [
    {
      path: 'list',
      component: () => import('@/smart-home/swagger/index.vue'),
      name: 'swagger list',
      meta: {
        title: 'swaggerList',
        }
    },
  ]
}

export default swaggerRouter
