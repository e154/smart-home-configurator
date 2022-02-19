import { RouteConfig } from 'vue-router'
import Develop from '@/layout/develop.vue'

const usersRouter: RouteConfig = {
  path: '/users',
  component: Develop,
  redirect: '/users/list',
  name: 'users',
  meta: {
    title: 'users',
    icon: 'table',
    alwaysShow: true
  },
  children: [
    {
      path: 'list',
      component: () => import('@/views/users/index.vue'),
      name: 'user list',
      meta: {
        title: 'userList',
        }
    },
  ]
}

export default usersRouter
