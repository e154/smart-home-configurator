import { RouteConfig } from 'vue-router'
import Develop from '@/layout/develop.vue'

const imagesRouter: RouteConfig = {
  path: '/images',
  component: Develop,
  redirect: '/images',
  name: 'images',
  meta: { hidden: false },
  children: [
    {
      path: '',
      component: () => import('@/views/images/index.vue'),
      name: 'images',
      meta: {
        title: 'images',
        icon: 'image',
        noCache: true
      }
    }
  ]
}

export default imagesRouter
