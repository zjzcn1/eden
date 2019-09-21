import NotFound from './views/404.vue'
import NotPerm from './views/403.vue'
import Main from './views/Main.vue'
<#list tables as table>
import ${table.className} from './views/${table.className}/${table.className}.vue'
</#list>

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
<#list tables as table>
  {
    path: '/',
    component: Main,
    name: '',
    icon: 'fa fa-dashboard',
    leaf: true,//只有一个节点
    children: [
      { path: '/${table.objectName}/list${table.className}', component: ${table.className}, name: '${table.tableComment}管理' }
    ]
  },
</#list>
  {
    path: '*',
    hidden: true,
    redirect: { path: '/404' }
  }
];

export default routes;
