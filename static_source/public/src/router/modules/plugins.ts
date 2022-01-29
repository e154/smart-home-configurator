import { RouteConfig } from 'vue-router'
import Layout from '@/layout/index.vue'

const pluginsRouter: RouteConfig = {
  path: '/plugins',
  component: Layout,
  redirect: '/plugins/list',
  name: 'plugins',
  meta: {
    title: 'plugins',
    icon: 'table',
    alwaysShow: true
  },
  children: [
    {
      path: 'list',
      component: () => import('@/smart-home/plugins/index.vue'),
      name: 'plugin list',
      meta: {
        title: 'pluginList',
        }
    },
    {
      path: 'edit/:name',
      component: () => import('@/smart-home/plugins/edit.vue'),
      props: true,
      name: 'plugin edit',
      meta: {
        title: 'pluginEdit',
        hidden: true
      }
    },
  ]
}

export default pluginsRouter
