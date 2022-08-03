import { RouteConfig } from 'vue-router'
import Develop from '@/layout/develop.vue'

const usersRouter: RouteConfig = {
  path: '/users',
  component: Develop,
  redirect: '/users/list',
  name: 'users',
  meta: {
    title: 'users',
    icon: 'user',
    alwaysShow: true
  },
  children: [
    {
      path: 'list',
      component: () => import('@/views/users/index.vue'),
      name: 'user list',
      meta: {
        title: 'UserList'
      }
    },
    {
      path: 'edit/:id',
      component: () => import('@/views/users/edit.vue'),
      props: true,
      name: 'user edit',
      meta: {
        title: 'UserEdit',
        hidden: true
      }
    },
    {
      path: 'new',
      component: () => import('@/views/users/new.vue'),
      name: 'user new',
      meta: {
        hidden: true,
        title: 'UserNew'
      }
    }
  ]
}

export default usersRouter
