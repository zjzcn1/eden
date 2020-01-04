const config = {
  localhost: {
    baseUrl: "http://localhost:8080"
  },
  prod: {
  }
};

const host = location.host;
let currentEnv = host.match(/\b(alpha|test|localhost)\b|$/)[0] || 'prod';

export default {
  url() {
    return config[currentEnv];
  },
  env() {
    return currentEnv;
  }
};
