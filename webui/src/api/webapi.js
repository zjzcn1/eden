import axios from 'axios';
import config from '../config'

export default {
  getCurrentUser() {
    return axios.get('staff/getCurrentUser');
  },
  logout() {
    axios.get(config.url().ssoLogoutUrl);
    window.location.href = config.url().ssoLoginUrl;
  },
  listUser(params) {
    return axios.post('listUser', params);
  }
}
