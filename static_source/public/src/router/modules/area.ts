import { RouteConfig } from 'vue-router'
import Layout from '@/layout/index.vue'

const areasRouter: RouteConfig = {
  path: '/areas',
  component: Layout,
  redirect: '/areas/list',
  name: 'areas',
  meta: {
    title: 'areas',
    icon: 'table',
    alwaysShow: true
  },
  children: [
    {
      path: 'list',
      component: () => import('@/smart-home/areas/areas_list.vue'),
      name: 'area list',
      meta: {
        title: 'areaList',
        }
    },
    {
      path: 'edit/:id',
      component: () => import('@/smart-home/areas/areas_edit.vue'),
      props: true,
      name: 'area edit',
      meta: {
        title: 'areaEdit',
        hidden: true
      }
    },
    {
      path: 'new',
      component: () => import('@/smart-home/areas/areas_new.vue'),
      props: true,
      name: 'area new',
      meta: {
        title: 'areaNew',
      }
    },
  ]
}

export default areasRouter
