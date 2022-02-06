import { RouteConfig } from 'vue-router'
import Layout from '@/layout/index.vue'

const imagesRouter: RouteConfig = {
  path: '/images',
  component: Layout,
  redirect: '/images/list',
  name: 'images',
  meta: {
    title: 'images',
    icon: 'table',
    alwaysShow: true
  },
  children: [
    {
      path: 'list',
      component: () => import('@/smart-home/images/browser.vue'),
      name: 'image list',
      meta: {
        title: 'imageList',
        }
    },
    // {
    //   path: 'edit/:id',
    //   component: () => import('@/smart-home/images/edit.vue'),
    //   props: true,
    //   name: 'image edit',
    //   meta: {
    //     title: 'imageEdit',
    //     hidden: true
    //   }
    // },
    // {
    //   path: 'new',
    //   component: () => import('@/smart-home/images/new.vue'),
    //   props: true,
    //   name: 'image new',
    //   meta: {
    //     title: 'imageNew',
    //   }
    // },
  ]
}

export default imagesRouter
