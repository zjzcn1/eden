<template>
    <section>
        <!--查询栏-->
        <el-form class="query-bar" :inline="true">
            <#list columns as column>
            <#if (!column.isCreateTimeColumn && !column.isUpdateTimeColumn && !column.isDeletedColumn)>
            <el-form-item label="${column.comment}:">
                <el-input v-model="queryParams.${column.propertyName}" clearable placeholder="${column.comment}"></el-input>
            </el-form-item>
            </#if>
            </#list>
            <el-form-item>
                <el-button plain round icon="el-icon-search" @click="queryList">查询</el-button>
            </el-form-item>
            <el-form-item style="float: right">
                <el-button type="primary" @click="handleCreate" icon="el-icon-plus">创建</el-button>
            </el-form-item>
        </el-form>

        <!--列表-->
        <el-table :data="dataList" highlight-current-row>
            <#list columns as column>
            <#if column.isEnabledColumn>
            <el-table-column prop="${column.propertyName}" label="${column.comment}" min-width="80">
                <template slot-scope="scope">
                    <el-tag :type="scope.row.${column.propertyName} === true ? 'success':'danger'">
                        {{scope.row.${column.propertyName} === true ? '有效':'无效'}}
                    </el-tag>
                </template>
            </el-table-column>
            <#elseif column.isCreateTimeColumn || column.isUpdateTimeColumn>
            <el-table-column prop="${column.propertyName}" label="${column.comment}" min-width="140">
                <template slot-scope="scope">
                    {{scope.row.${column.propertyName} | formatDateTime}}
                </template>
            </el-table-column>
            <#elseif !column.isDeletedColumn>
            <el-table-column prop="${column.propertyName}" label="${column.comment}" min-width="100">
            </el-table-column>
            </#if>
            </#list>

            <el-table-column align="center" label="操作">
                <template slot-scope="scope">
                    <el-button type="text" @click="handleUpdate(scope.$index, scope.row)">修改</el-button>
                    <el-divider direction="vertical"></el-divider>
                    <el-popover placement="top" width="160" v-model="deleteFormVisible">
                      <p>确定删除吗？</p>
                      <div style="text-align: right; margin: 0">
                        <el-button size="mini" @click="deleteFormVisible = false">取消</el-button>
                        <el-button type="primary" size="mini" @click="handleDelete(scope.$index, scope.row)">确定</el-button>
                      </div>
                      <el-button type="text" slot="reference">删除</el-button>
                    </el-popover>
                </template>
            </el-table-column>
        </el-table>
        <!--分页栏-->
        <el-pagination layout="total, sizes, prev, pager, next"
                       @current-change="handlePageChange"
                       :page-size="size"
                       :total="total"
                       style="float:right;">
        </el-pagination>

        <!--新增界面-->
        <el-dialog title="创建" :visible.sync="createFormVisible" :close-on-click-modal="false">
            <el-form :model="createForm" label-width="120px" :rules="createFormRules" ref="createForm">
            <#list columns as column>
            <#if (!column.isPrimaryKey && !column.isCreateTimeColumn && !column.isUpdateTimeColumn && !column.isDeletedColumn)>
                <el-form-item label="${column.comment}" prop="${column.propertyName}">
                    <el-input v-model="createForm.${column.propertyName}" clearable></el-input>
                </el-form-item>
            </#if>
            </#list>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click.native="createFormVisible = false">取消</el-button>
                <el-button type="primary" @click.native="createSubmit">提交</el-button>
            </div>
        </el-dialog>

        <!--编辑界面-->
        <el-dialog title="修改" :visible.sync="updateFormVisible" :close-on-click-modal="false">
            <el-form :model="updateForm" label-width="120px" :rules="updateFormRules" ref="updateForm">
            <#list columns as column>
            <#if column.isEnabledColumn>
                <el-form-item label="${column.comment}" prop="${column.propertyName}">
                    <el-radio v-model="updateForm.${column.propertyName}" :label="true">有效</el-radio>
                    <el-radio v-model="updateForm.${column.propertyName}" :label="false">无效</el-radio>
                </el-form-item>
            <#elseif (!column.isPrimaryKey && !column.isCreateTimeColumn && !column.isUpdateTimeColumn && !column.isDeletedColumn)>
                <el-form-item label="${column.comment}" prop="${column.propertyName}">
                    <el-input v-model="updateForm.${column.propertyName}" clearable></el-input>
                </el-form-item>
            </#if>
            </#list>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click.native="updateFormVisible = false">取消</el-button>
                <el-button type="primary" @click.native="updateSubmit">提交</el-button>
            </div>
        </el-dialog>
    </section>
</template>

<script>
  import Webapi from '@/common/webapi';

  export default {
    data() {
      return {
        queryParams: {},
        dataList: [],
        total: 0,
        page: 1,
        size: 10,

        createFormVisible: false,
        createForm: {},
        createFormRules: {
        <#list columns as column>
          <#if (!column.isPrimaryKey && !column.isCreateTimeColumn && !column.isUpdateTimeColumn && !column.isDeletedColumn)>
          ${column.propertyName}: [
            { required: true, message: '请输入${column.comment}', trigger: 'blur' },
          ],
          </#if>
        </#list>
        },

        updateFormVisible: false,
        updateForm: {},
        updateFormRules: {
        <#list columns as column>
          <#if (!column.isPrimaryKey && !column.isCreateTimeColumn && !column.isUpdateTimeColumn && !column.isDeletedColumn)>
          ${column.propertyName}: [
            { required: true, message: '请输入${column.comment}', trigger: 'blur' },
          ],
          </#if>
        </#list>
        },

        deleteFormVisible: false
      }
    },
    mounted() {
       this.queryList();
    },
    methods: {
      handlePageChange(val) {
        this.page = val;
        this.queryList();
      },
      queryList() {
        let params = {
          size: this.size,
          page: this.page,
          params: this.queryParams
        };
        Webapi.page${table.className}(params).then(
          res => {
            this.dataList = res.data.data.list;
            this.total = res.data.data.total;
          }
        );
      },
      handleCreate() {
        this.createFormVisible = true;
        this.createForm = {};
      },
      createSubmit() {
        this.$refs.createForm.validate((valid) => {
          if (valid) {
            Webapi.create${table.className}(this.createForm).then(
              () => {
                this.createFormVisible = false;
                this.queryList();
                this.$notify({
                    title: '成功',
                    message: '提交成功',
                    type: 'success'
                });
              }
            );
          }
        });
      },
      handleUpdate(index, row) {
        this.updateFormVisible = true;
        this.updateForm = Object.assign({}, row);
      },
      updateSubmit() {
        this.$refs.updateForm.validate((valid) => {
          if (valid) {
            Webapi.update${table.className}(this.updateForm).then(
              () => {
                this.updateFormVisible = false;
                this.queryList();
                this.$notify({
                    title: '成功',
                    message: '提交成功',
                    type: 'success'
                });
              }
            );
          }
        });
      },
      handleDelete(index, row) {
        this.deleteFormVisible = false;
        Webapi.delete${table.className}(row.id).then(
          () => {
            this.queryList();
            this.$notify({
                title: '成功',
                message: '删除成功',
                type: 'success'
            });
          }
        );
      }
    }
  }
</script>

<style scoped>

</style>
