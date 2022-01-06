import { RouteConfig } from 'vue-router'
import Layout from '@/layout/index.vue'

const entitiesRouter: RouteConfig = {
  path: '/entities',
  component: Layout,
  redirect: '/entities/list',
  name: 'entities',
  meta: {
    title: 'entities',
    icon: 'table',
    alwaysShow: true
  },
  children: [
    {
      path: 'list',
      component: () => import('@/smart-home/entities/entities_list.vue'),
      name: 'entity list',
      meta: {
        title: 'entityList',
        }
    },
    {
      path: 'edit/:id',
      component: () => import('@/smart-home/entities/entities_edit.vue'),
      props: true,
      name: 'entity edit',
      meta: {
        title: 'entityEdit',
        hidden: true
      }
    },
    {
      path: 'new',
      component: () => import('@/smart-home/entities/entities_new.vue'),
      props: true,
      name: 'entity new',
      meta: {
        title: 'entityNew',
      }
    },
  ]
}

export default entitiesRouter
