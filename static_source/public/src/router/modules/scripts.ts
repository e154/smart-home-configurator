import { RouteConfig } from 'vue-router'
import Layout from '@/layout/index.vue'

const scriptsRouter: RouteConfig = {
  path: '/scripts',
  component: Layout,
  redirect: '/scripts/list',
  name: 'scripts',
  meta: {
    title: 'scripts',
    icon: 'table',
    alwaysShow: true
  },
  children: [
    {
      path: 'list',
      component: () => import('@/smart-home/scripts/index.vue'),
      name: 'script list',
      meta: {
        title: 'scriptList',
        }
    },
    {
      path: 'edit/:id',
      component: () => import('@/smart-home/scripts/edit.vue'),
      props: true,
      name: 'script edit',
      meta: {
        title: 'scriptEdit',
        hidden: true
      }
    },
    {
      path: 'new',
      component: () => import('@/smart-home/scripts/new.vue'),
      props: true,
      name: 'script new',
      meta: {
        title: 'scriptNew',
      }
    },

  ]
}

export default scriptsRouter
