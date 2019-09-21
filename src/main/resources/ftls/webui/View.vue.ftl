<template>
    <section>
        <!--工具条-->
        <el-row style="margin-bottom: 10px">
            <el-col :span="8">
                <el-input placeholder="请输入内容" v-model="filters.value" class="input-with-select">
                    <el-select v-model="filters.name" slot="prepend" placeholder="请选择">
                        <el-option label="ID" value="id:NumberEq"></el-option>
                    </el-select>
                    <el-button slot="append" icon="el-icon-search" @click="queryList"></el-button>
                </el-input>
            </el-col>
            <el-col :offset="13" :span="3">
                <el-button type="primary" plain @click="handleAdd">新增</el-button>
            </el-col>
        </el-row>

        <!--列表-->
        <el-table :data="dataList" highlight-current-row v-loading="listLoading" style="width: 100%;">
            <#list columns as column>
            <el-table-column prop="${column.propertyName}" label="${column.comment}" width="100">
            </el-table-column>
            </#list>

            <el-table-column label="操作">
                <template slot-scope="scope">
                    <el-button type="warning" size="small" @click="handleEdit(scope.$index, scope.row)">修改</el-button>
                </template>
            </el-table-column>
        </el-table>

        <!--工具条-->
        <el-col :span="24" style="padding: 10px 0">
            <el-pagination layout="total, sizes, prev, pager, next"
                           @current-change="handleCurrentChange"
                           :page-size="20"
                           :total="total"
                           style="float:right; margin-right:-5px">
            </el-pagination>
        </el-col>

        <!--新增界面-->
        <el-dialog title="新增" :visible.sync="addFormVisible" :close-on-click-modal="false">
            <el-form :model="addForm" label-width="80px" :rules="addFormRules" ref="addForm">
<#list columns as column>
                <el-form-item label="${column.comment}" prop="${column.propertyName}">
                    <el-input v-model="addForm.${column.propertyName}" auto-complete="off"></el-input>
                </el-form-item>
</#list>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click.native="addFormVisible = false">取消</el-button>
                <el-button type="primary" @click.native="addSubmit">提交</el-button>
            </div>
        </el-dialog>

        <!--编辑界面-->
        <el-dialog title="编辑" :visible.sync="editFormVisible" :close-on-click-modal="false">
            <el-form :model="editForm" label-width="80px" :rules="editFormRules" ref="editForm">
                <#list columns as column>
                <el-form-item label="${column.comment}" prop="${column.propertyName}">
                    <el-input v-model="editForm.${column.propertyName}" auto-complete="off"></el-input>
                </el-form-item>
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
        filters: {
          name: ''
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
          current: this.page
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
        }
    }
  }
</script>

<style scoped>
    .el-input .el-select {
        width: 120px;
    }
</style>
