import { RouteConfig } from 'vue-router'
import Develop from '@/layout/develop.vue'

const entitiesRouter: RouteConfig = {
  path: '/entities',
  component: Develop,
  redirect: '/entities/list',
  name: 'entities',
  meta: {
    title: 'entities',
    icon: 'entity2',
    alwaysShow: true
  },
  children: [
    {
      path: 'list',
      component: () => import('@/views/entities/index.vue'),
      name: 'entity list',
      meta: {
        title: 'entityList'
      }
    },
    {
      path: 'edit/:id',
      component: () => import('@/views/entities/edit.vue'),
      props: true,
      name: 'entity edit',
      meta: {
        title: 'entityEdit',
        hidden: true
      }
    },
    {
      path: 'new',
      component: () => import('@/views/entities/new.vue'),
      props: true,
      name: 'entity new',
      meta: {
        title: 'entityNew'
      }
    }
  ]
}

export default entitiesRouter
