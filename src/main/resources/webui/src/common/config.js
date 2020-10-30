const config = {
  localhost: {
    baseURL: "http://localhost:8080",
    websocketURL: 'ws://localhost:8088/ws'
  },
  prod: {
  }
};

const host = location.host;
let env = host.match(/\b(alpha|test|localhost)\b|$/)[0] || 'prod';

export default {
  baseURL() {
    return config[env].baseURL;
  },
  websocketURL() {
    let url = document.location.href;
    if(env === 'localhost') {
      url = config.localhost.websocketURL;
      // url = 'ws://192.168.10.10:8888/ws';
    } else {
      url = 'ws://' + url.split('//')[1].split('/')[0] + '/ws';
    }
    return url;
  },
  env() {
    return env;
  }
};
