import axios from 'axios';

export default {
<#list tables as table>
  listAll${table.className}(params) {
    return axios.post('${table.objectName}/listAll${table.className}', params);
  },
  list${table.className}(params) {
    return axios.post('${table.objectName}/list${table.className}', params);
  },
  create${table.className}(params) {
    return axios.post('${table.objectName}/create${table.className}', params);
  },
  update${table.className}(params) {
    return axios.put('${table.objectName}/update${table.className}', params);
  },
  delete${table.className}(id) {
    return axios.delete('${table.objectName}/delete${table.className}', {params: { id: id }});
  },
</#list>
}
