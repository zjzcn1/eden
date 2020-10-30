import axios from 'axios';

export default {
<#list tables as table>
  create${table.className}(params) {
      return axios.post('${table.objectName}/create', params);
  },
  update${table.className}(params) {
      return axios.put('${table.objectName}/update', params);
  },
  delete${table.className}(id) {
  return axios.delete('${table.objectName}/delete', {params: { id: id }});
  },
  get${table.className}(id) {
    return axios.get('${table.objectName}/get', {params: { id: id }});
  },
  count${table.className}(params) {
    return axios.post('${table.objectName}/count', params);
  },
  list${table.className}(params) {
    return axios.post('${table.objectName}/list', params);
  },
  page${table.className}(params) {
    return axios.post('${table.objectName}/page', params);
  },

</#list>
}
