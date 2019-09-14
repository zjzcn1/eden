const config = {
  localhost: {
    baseUrl: "http://localhost:8081"
  },
  prod: {
  }
};

const host = location.host;
let currentEnv = host.match(/\b(alpha|test|localhost)\b|$/)[0] || 'prod';

console.log('Using env config: ' + currentEnv);

export default {
  url() {
    return config[currentEnv];
  },
  env() {
    return currentEnv;
  }
};
