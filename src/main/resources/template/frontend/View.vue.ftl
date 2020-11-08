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
                <el-button type="primary" @click="showCreate" icon="el-icon-plus">创建</el-button>
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
                    <el-button type="text" @click="showUpdate(scope.$index, scope.row)">修改</el-button>
                    <el-divider direction="vertical"></el-divider>
                    <el-popconfirm title="确定删除吗？" @onConfirm="submitDelete(scope.$index, scope.row)">
                        <el-button type="text" slot="reference">删除</el-button>
                    </el-popconfirm>
                </template>
            </el-table-column>
        </el-table>
        <!--分页栏-->
        <el-pagination layout="total, sizes, prev, pager, next"
                       @current-change="onPageChange"
                       :page-size="size"
                       :total="total"
                       style="float:right;">
        </el-pagination>

        <!--创建对话框-->
        <el-dialog title="创建" :visible.sync="createFormVisible" :close-on-click-modal="false">
            <el-form :model="createForm" label-width="120px" :rules="createFormRules" ref="createForm" style="width: 80%">
            <#list columns as column>
            <#if (!column.isPrimaryKey && !column.isCreateTimeColumn && !column.isUpdateTimeColumn && !column.isDeletedColumn)>
                <el-form-item label="${column.comment}" prop="${column.propertyName}">
                    <el-input v-model="createForm.${column.propertyName}" clearable></el-input>
                </el-form-item>
            </#if>
            </#list>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button icon="el-icon-close" @click.native="createFormVisible = false">取消</el-button>
                <el-button icon="el-icon-upload" type="primary" @click.native="createSubmit">提交</el-button>
            </div>
        </el-dialog>

        <!--修改对话框-->
        <el-dialog title="修改" :visible.sync="updateFormVisible" :close-on-click-modal="false">
            <el-form :model="updateForm" label-width="120px" :rules="updateFormRules" ref="updateForm" style="width: 80%">
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
                <el-button icon="el-icon-close" @click.native="updateFormVisible = false">取消</el-button>
                <el-button icon="el-icon-upload" type="primary"  @click.native="submitUpdate">提交</el-button>
            </div>
        </el-dialog>
    </section>
</template>

<script>
  import webapi from '@/common/webapi';

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
        }
      }
    },
    mounted() {
       this.queryList();
    },
    methods: {
      onPageChange(val) {
        this.page = val;
        this.queryList();
      },
      queryList() {
        let params = {
          size: this.size,
          page: this.page,
          params: this.queryParams
        };
        webapi.page${table.className}(params).then(
          res => {
            this.dataList = res.data.data.list;
            this.total = res.data.data.total;
          }
        );
      },
      showCreate() {
        this.createFormVisible = true;
        this.createForm = {};
      },
      submitCreate() {
        this.$refs.createForm.validate((valid) => {
          if (valid) {
            webapi.create${table.className}(this.createForm).then(
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
      showUpdate(index, row) {
        this.updateFormVisible = true;
        this.updateForm = Object.assign({}, row);
      },
      submitUpdate() {
        this.$refs.updateForm.validate((valid) => {
          if (valid) {
            webapi.update${table.className}(this.updateForm).then(
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
      submitDelete(index, row) {
        row.deleteFormVisible = false;
        webapi.delete${table.className}(row.id).then(
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

<style scoped lang="scss">

</style>
