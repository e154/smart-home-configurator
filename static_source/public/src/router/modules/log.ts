import { RouteConfig } from 'vue-router'
import Layout from '@/layout/index.vue'

const logsRouter: RouteConfig = {
  path: '/logs',
  component: Layout,
  redirect: '/logs/list',
  name: 'logs',
  meta: {
    title: 'logs',
    icon: 'table',
    alwaysShow: true
  },
  children: [
    {
      path: 'list',
      component: () => import('@/smart-home/log/index.vue'),
      name: 'log list',
      meta: {
        title: 'logList',
        }
    },
  ]
}

export default logsRouter
