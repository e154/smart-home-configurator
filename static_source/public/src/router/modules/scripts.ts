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
      component: () => import('@/smart-home/scripts/scripts_list.vue'),
      name: 'script list',
      meta: {
        title: 'scriptList',
        }
    },
    {
      path: 'edit/:id',
      component: () => import('@/smart-home/scripts/scripts_edit.vue'),
      props: true,
      name: 'script edit',
      meta: {
        title: 'scriptEdit',
        hidden: true
      }
    },

  ]
}

export default scriptsRouter
