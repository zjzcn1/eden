import NotFound from './views/404.vue'
import NotPerm from './views/403.vue'
import Main from './views/Main.vue'
import User from './views/User.vue'

let routes = [
  {
    path: '/',
    component: Main,
    name: '',
    hidden: true,
    children: [
      { path: '/404', component: NotFound, name: '404' }
    ]
  },
  {
    path: '/',
    component: Main,
    name: '',
    hidden: true,
    children: [
      { path: '/403', component: NotPerm, name: '403' }
    ]
  },
  {
    path: '/',
    component: Main,
    name: '',
    icon: 'fa fa-dashboard',
    leaf: true,//只有一个节点
    children: [
      { path: '/user', component: User, name: '用户管理' }
    ]
  },
  {
    path: '*',
    hidden: true,
    redirect: { path: '/404' }
  }
];

export default routes;
