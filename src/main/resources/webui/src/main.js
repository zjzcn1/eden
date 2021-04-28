import Vue from 'vue'
import App from './App'
import routes from './common/routes'
import config from './common/config'
import utils from './common/utils'
import axios from 'axios';
import Element from 'element-ui'
import './styles/style-variables.scss'
import VueRouter from 'vue-router'
import 'font-awesome/css/font-awesome.min.css'
import JSONbig from 'json-bigint'
import VeCharts from 've-charts'
import NProgress from 'nprogress'
import 'nprogress/nprogress.css'

Vue.use(Element, {size: 'small'});
Vue.use(VueRouter);
Vue.use(VeCharts);
const {Notification} = Element;
NProgress.configure({ showSpinner: false });

Vue.prototype.formatDateTimeMS = (value) => {
  return utils.formatDateTimeMS(value);
};
Vue.prototype.formatDateTime = (value) => {
  return utils.formatDateTime(value);
};
Vue.prototype.formatDate = (value) => {
  return utils.formatDate(value);
};
Vue.prototype.formatTime = (value) => {
  return utils.formatTime(value);
};

Vue.filter('formatDateTimeMS', (value) => {
  return utils.formatDateTimeMS(value);
});
Vue.filter('formatDateTime', (value) => {
  return utils.formatDateTime(value);
});
Vue.filter('formatDate', (value) => {
  return utils.formatDate(value);
});
Vue.filter('formatTime', (value) => {
  return utils.formatTime(value);
});

const router = new VueRouter({
  routes
});

axios.defaults.baseURL = config.baseURL();
axios.defaults.withCredentials = true;
axios.defaults.transformResponse = [
  (data) => {
    return JSONbig.parse(data);
  }
];

axios.interceptors.request.use(
  (config) => {
    NProgress.start();
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
)
axios.interceptors.response.use(
  response => {
    NProgress.done();
    if (response.data.code < 400) {
      return response;
    } else if (response.data.code === 401) {
      window.location.href = config.url().ssoLoginUrl;
    } else if (response.data.code === 403) {
      router.replace('/403');
    } else {
      Notification.error({
        title: '错误',
        message: response.data.message,
      });
    }
    return Promise.reject(response);
  },
  error => {
    NProgress.done();
    if (error.response && error.response.status === 401) {
      window.location.href = config.url().ssoLoginUrl;
    } else {
      Notification.error({
        title: '错误',
        message: '请求错误',
      });
      return Promise.reject(error);
    }
  }
);

new Vue({
  router,
  render: h => h(App)
}).$mount('#app');

