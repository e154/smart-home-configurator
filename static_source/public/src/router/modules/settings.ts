import {RouteConfig} from 'vue-router';
import Develop from '@/layout/develop.vue';

const settingsRouter: RouteConfig = {
  path: '/settings',
  component: Develop,
  redirect: '/settings',
  name: 'settings',
  meta: {
    icon: 'settings',
    title: 'settings',
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

export default settingsRouter;
