<template>
    <section>
        <!--工具条-->
        <el-row style="margin-bottom: 10px">
            <el-col :span="6">
                <el-input placeholder="请输入内容" v-model="query.value" class="input-with-select">
                    <el-select v-model="query.name" slot="prepend" placeholder="请选择">
                        <#list columns as column>
                        <#if ((column.typeName=="Integer" || column.typeName=="Long" || column.typeName=="String")
                        && !column.isEnabledColumn && !column.isDeletedColumn) >
                            <el-option label="${column.comment}" value="${column.columnName}"></el-option>
                        </#if>
                        </#list>
                    </el-select>
                </el-input>
            </el-col>
            <el-col :offset="1" :span="2">
                <el-button plain round icon="el-icon-search" @click="queryList">查询</el-button>
            </el-col>
            <el-col :offset="13" :span="2">
                <el-button type="primary" icon="el-icon-circle-plus-outline" @click="handleAdd">新增</el-button>
            </el-col>
        </el-row>

        <!--列表-->
        <el-table :data="dataList" highlight-current-row v-loading="listLoading" style="width: 100%;">
            <#list columns as column>
                <#if column.isEnabledColumn>
                    <el-table-column prop="${column.propertyName}" label="${column.comment}" width="${column.columnWidth}">
                        <template slot-scope="scope">
                            <el-tag :type="scope.row.${column.propertyName} === true ? 'success':'danger'">
                                {{scope.row.${column.propertyName} === true ? '有效':'无效'}}
                            </el-tag>
                        </template>
                    </el-table-column>
                <#elseif !column.isDeletedColumn>
                    <el-table-column prop="${column.propertyName}" label="${column.comment}" <#if column.columnWidth??>width="${column.columnWidth}"<#else>min-width="100"</#if>>
                    </el-table-column>
                </#if>
            </#list>

            <el-table-column label="操作" width="180">
                <template slot-scope="scope">
                    <el-button type="warning" size="small" icon="el-icon-edit"
                               @click="handleEdit(scope.$index, scope.row)">修改</el-button>
                    <el-button type="danger" size="small" icon="el-icon-delete"
                               @click="handleDelete(scope.$index, scope.row)">删除</el-button>
                </template>
            </el-table-column>
        </el-table>

        <!--分页-->
        <el-col :span="24" style="padding: 10px 0">
            <el-pagination layout="total, sizes, prev, pager, next"
                           @current-change="handleCurrentChange"
                           :page-size="20"
                           :total="total"
                           style="float:right; margin-right:-5px">
            </el-pagination>
        </el-col>

        <!--新增界面-->
        <el-dialog title="新增" class="dialog" :visible.sync="addFormVisible" :close-on-click-modal="false">
            <el-form :model="addForm" label-width="120px" :rules="addFormRules" ref="addForm">
                <#list columns as column>
                    <#if (!column.isCreateTimeColumn && !column.isUpdateTimeColumn && !column.isPrimaryKey && !column.isDeletedColumn && !column.isEnabledColumn)>
                        <el-form-item label="${column.comment}" prop="${column.propertyName}">
                            <el-input v-model="addForm.${column.propertyName}" auto-complete="off"></el-input>
                        </el-form-item>
                    </#if>
                </#list>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click.native="addFormVisible = false">取消</el-button>
                <el-button type="primary" @click.native="addSubmit">提交</el-button>
            </div>
        </el-dialog>

        <!--编辑界面-->
        <el-dialog title="编辑" class="dialog" :visible.sync="editFormVisible" :close-on-click-modal="false">
            <el-form :model="editForm" label-width="120px" :rules="editFormRules" ref="editForm">
                <#list columns as column>
                    <#if column.isEnabledColumn>
                        <el-form-item label="${column.comment}" prop="${column.propertyName}">
                            <el-radio v-model="editForm.${column.propertyName}" :label="true">有效</el-radio>
                            <el-radio v-model="editForm.${column.propertyName}" :label="false">无效</el-radio>
                        </el-form-item>
                    <#elseif (!column.isCreateTimeColumn && !column.isUpdateTimeColumn && !column.isPrimaryKey && !column.isDeletedColumn)>
                        <el-form-item label="${column.comment}" prop="${column.propertyName}">
                            <el-input v-model="editForm.${column.propertyName}" auto-complete="off"></el-input>
                        </el-form-item>
                    </#if>
                </#list>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click.native="editFormVisible = false">取消</el-button>
                <el-button type="primary" @click.native="editSubmit">提交</el-button>
            </div>
        </el-dialog>
    </section>
</template>

<script>
  import Webapi from '../../webapi';

  export default {
    data() {
      return {
        query: {
          name: '',
          value: ''
        },
        dataList: [],
        total: 0,
        page: 1,
        listLoading: false,

        addFormVisible: false,
        addFormRules: {

        },
        addForm: {},

        editFormVisible: false,
        editFormRules: {
        },
        editForm: {}
      }
    },
    mounted() {
      this.queryList();
    },
    methods: {
      handleCurrentChange(val) {
        this.page = val;
        this.queryList();
      },
      queryList() {
        let params = {
          size: 20,
          current: this.page,
          params: {queryName: this.query.name, queryValue: this.query.value}
        };

        this.listLoading = true;
        Webapi.list${table.className}(params).then(
          res => {
            this.listLoading = false;
            if (res.data && res.data.data) {
              this.dataList = res.data.data.list;
              this.total = res.data.data.total;
            }
          }
        );
      },
        handleAdd() {
            this.addFormVisible = true;
            this.addForm = {
                enable: true
            };
        },
        addSubmit() {
            this.$refs.addForm.validate((valid) => {
                if (valid) {
                    this.addFormVisible = false;
                    Webapi.create${table.className}(this.addForm).then(
                            res => {
                        if (res.data && res.data.code === 200) {
                        this.queryList();
                        this.$notify({
                            title: '成功',
                            message: '提交成功',
                            type: 'success'
                        });
                    }
                }
                );
                }
            });
        },
        handleEdit(index, row) {
            this.editFormVisible = true;
            this.editForm = Object.assign({}, row);
        },
        editSubmit() {
            this.$refs.editForm.validate((valid) => {
                if (valid) {
                    this.editFormVisible = false;
                    Webapi.update${table.className}(this.editForm).then(
                            res => {
                        if (res.data && res.data.code === 200) {
                        this.queryList();
                        this.$notify({
                            title: '成功',
                            message: '提交成功',
                            type: 'success'
                        });
                    }
                }
                );
                }
            });
        },
        handleDelete(index, row) {
          this.$confirm('确认要删除吗？', '提示', {
              type: 'warning'
          }).then(() => {
              Webapi.delete${table.className}(row.id).then(
                  res => {
                      if (res.data && res.data.code === 200) {
                          this.queryList();
                          this.$notify({
                              title: '成功',
                              message: '提交成功',
                              type: 'success'
                          });
                      }
                  }
              );
          }).catch(() => {
          });
        }
    }
  }
</script>

<style scoped>
    .el-input .el-select {
        width: 120px;
    }

    .dialog .el-input {
        width: 300px;
    }
</style>
