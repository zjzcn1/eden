import Vue from 'vue'
import App from './App'

import Element from 'element-ui'
import { Notification } from 'element-ui';
import 'font-awesome/css/font-awesome.min.css'
import './styles/style-variables.scss'
import './styles/iconfont.css'
import VueRouter from 'vue-router'
import routes from './routes'
import config from './config'
import axios from 'axios';


Vue.filter('formatDate', (value) => {
  return new Date(value).format('yyyy-MM-dd hh:mm:ss');
});

Vue.use(Element, {
  size: 'small'
});

Vue.use(VueRouter);
axios.defaults.baseURL = config.url()['baseUrl'];
axios.defaults.withCredentials = false;

const router = new VueRouter({
  routes
});

axios.interceptors.response.use(
  response => {
    if (response.data.code < 400) {
      return response;
    } else if (response.data.code === 401) {
      window.location.href = config.url().ssoLoginUrl;
    } else  if (response.data.code === 403) {
      router.replace('/403');
    } else {
      Notification.error({
        title: '错误',
        message: response.data.msg,
      });
      return response;
    }
  },
  error => {
    if (error.response && error.response.status === 401) {
      window.location.href = config.url().ssoLoginUrl;
    } else {
      Notification.error({
        title: '错误',
        message: error.message,
      });
      return error;
    }
  }
);

new Vue({
  router,
  render: h => h(App)
}).$mount('#app');

