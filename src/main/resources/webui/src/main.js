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

Vue.use(Element, {size: 'small'});
Vue.use(VueRouter);
Vue.use(VeCharts);

const {Loading, Notification} = Element;

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

let loadingInstance = null;
axios.interceptors.request.use(
  (config) => {
    loadingInstance = Loading.service({ fullscreen: true });
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
)
axios.interceptors.response.use(
  response => {
    loadingInstance.close();
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
    loadingInstance.close();
    if (error.response && error.response.status === 401) {
      window.location.href = config.url().ssoLoginUrl;
    } else {
      Notification.error({
        title: '错误',
        message: error.message,
      });
      return Promise.reject(error);
    }
  }
);

new Vue({
  router,
  render: h => h(App)
}).$mount('#app');

