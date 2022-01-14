import { RouteConfig } from 'vue-router'
import Layout from '@/layout/index.vue'

const automationRouter: RouteConfig = {
  path: '/automation',
  component: Layout,
  redirect: '/automation/list',
  name: 'automation',
  meta: {
    title: 'automation',
    icon: 'table',
    alwaysShow: true
  },
  children: [
    {
      path: 'list',
      component: () => import('@/smart-home/automation/index.vue'),
      name: 'task list',
      meta: {
        title: 'taskList',
        }
    },
    {
      path: 'edit/:id',
      component: () => import('@/smart-home/automation/edit.vue'),
      props: true,
      name: 'task edit',
      meta: {
        title: 'taskEdit',
        hidden: true
      }
    },
    {
      path: 'new',
      component: () => import('@/smart-home/automation/new.vue'),
      props: true,
      name: 'task new',
      meta: {
        title: 'taskNew',
      }
    },
  ]
}

export default automationRouter
