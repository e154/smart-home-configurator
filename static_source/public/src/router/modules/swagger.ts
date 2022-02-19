import {RouteConfig} from 'vue-router';
import Develop from '@/layout/develop.vue';

const swaggerRouter: RouteConfig = {
  path: '/swagger',
  component: Develop,
  redirect: '/swagger/index',
  meta: {hidden: false},
  children: [
    {
      path: 'index',
      component: () => import(/* webpackChunkName: "swagger" */ '@/views/swagger/index.vue'),
      name: 'Swagger',
      meta: {
        title: 'swagger',
        icon: 'table',
        noCache: true
      }
    }
  ]
};

export default swaggerRouter;
