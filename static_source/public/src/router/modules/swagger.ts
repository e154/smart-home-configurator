import { RouteConfig } from 'vue-router'
import Develop from '@/layout/develop.vue'

const swaggerRouter: RouteConfig = {
  path: '/swagger',
  component: Develop,
  redirect: '/swagger',
  meta: { hidden: false },
  children: [
    {
      path: '',
      component: () => import(/* webpackChunkName: "swagger" */ '@/views/swagger/index.vue'),
      name: 'Swagger',
      meta: {
        title: 'swagger',
        icon: 'swagger',
        noCache: true
      }
    }
  ]
}

export default swaggerRouter
