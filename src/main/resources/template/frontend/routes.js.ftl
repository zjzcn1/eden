let routes = [
  {
    path: '',
    redirect: '/home',
    meta: {hidden: true}
  },
  {
    path: '/',
    component: () => import("@/views/Main"),
    meta: {leaf: true},
    children: [
      {
        path: '/home',
        name: '首页',
        meta: {icon: 'iconfont icon-home', breadcrumb: [{name: '首页', path: '/home'}]},
        component: () => import("@/views/Home"),
      },
    ]
  },
<#list tables as table>
  {
    path: '/',
    component: () => import("@/views/Main"),
    name: '',
    meta: {leaf: true, icon: 'iconfont icon-home'},
    children: [
      {
        path: '/${table.objectName}/list',
        name: '${table.tableComment}管理',
        meta: {icon: 'iconfont icon-home'},
        component: () => import("@/views/${table.className}")
      }
    ]
  },
</#list>

  {
    path: '/',
    component: () => import("@/views/Main"),
    name: '',
    meta: {hidden: true},
    children: [
      {
        path: '/404',
        name: '页面未找到',
        meta: {},
        component: () => import("@/views/404")
      }
    ]
  },
  {
    path: '/',
    component: () => import("@/views/Main"),
    name: '',
    meta: {hidden: true},
    children: [
      {
        path: '/403',
        name: '没有权限',
        meta: {},
        component: () => import("@/views/403")
      }
    ]
  },
  {
    path: '*',
    redirect: {path: '/404'},
    meta: {hidden: true},
  }
];

export default routes;
