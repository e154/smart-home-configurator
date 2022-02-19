import { RouteConfig } from 'vue-router'
import Develop from '@/layout/develop.vue'

const imagesRouter: RouteConfig = {
  path: '/images',
  component: Develop,
  redirect: '/images/browsers',
  name: 'images',
  meta: {hidden: false},
  children: [
    {
      path: 'browsers',
      component: () => import('@/views/images/index.vue'),
      name: 'images',
      meta: {
        title: 'images',
        icon: 'table',
        noCache: true
        }
    },
  ]
}

export default imagesRouter
