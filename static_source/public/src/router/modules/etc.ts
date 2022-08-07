import {RouteConfig} from 'vue-router';
import Develop from '@/layout/develop.vue';

const etcRouter: RouteConfig = {
  path: '/etc',
  component: Develop,
  redirect: '/etc',
  name: 'etc',
  meta: {
    icon: 'settings',
    title: 'etc',
    noCache: true,
  },
  children: [
    {
      path: 'variables',
      component: () => import('@/views/variables/index.vue'),
      name: 'variables',
      meta: {
        title: 'variables'
      }
    },
    {
      path: 'plugins',
      component: () => import('@/views/plugins/index.vue'),
      name: 'plugins',
      meta: {
        title: 'plugins'
      }
    },
    {
      path: 'swagger',
      component: () => import('@/views/swagger/index.vue'),
      name: 'swagger',
      meta: {
        title: 'swagger'
      }
    },
    {
      path: 'images',
      component: () => import('@/views/images/index.vue'),
      name: 'images',
      meta: {
        title: 'images'
      }
    },
    {
      path: 'areas',
      component: () => import('@/views/areas/index.vue'),
      name: 'area list',
      meta: {
        title: 'areaList'
      }
    },
    {
      path: 'areas/edit/:id',
      component: () => import('@/views/areas/edit.vue'),
      props: true,
      name: 'area edit',
      meta: {
        title: 'areaEdit',
        hidden: true
      }
    },
    {
      path: 'areas/new',
      component: () => import('@/views/areas/new.vue'),
      props: true,
      name: 'area new',
      meta: {
        title: 'areaNew',
        hidden: true
      }
    }
  ]
};

export default etcRouter;
