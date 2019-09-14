<template>
    <section>
        <!--工具条-->
        <el-row style="margin-bottom: 10px">
            <el-col :span="8">
                <el-input placeholder="请输入内容" v-model="filters.value" class="input-with-select">
                    <el-select v-model="filters.name" slot="prepend" placeholder="请选择">
                        <el-option label="ID" value="id:NumberEq"></el-option>
                        <el-option label="机器人编号" value="robot_code:Like"></el-option>
                        <el-option label="站点ID" value="station_id:NumberEq"></el-option>
                        <el-option label="楼宇ID" value="building_id:NumberEq"></el-option>
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
            <el-table-column prop="id" label="ID" width="50">
            </el-table-column>
            <el-table-column prop="username" label="用户名" width="100">
            </el-table-column>
            <el-table-column prop="password" label="密码" width="65">
            </el-table-column>
            <el-table-column prop="enabled" label="启用" width="60">
                <template slot-scope="scope">
                    <el-tag size="small" :type="scope.row.enabled?'success':'danger'">
                        {{ scope.row.enabled ? '是' : '否' }}
                    </el-tag>
                </template>
            </el-table-column>
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
                <el-form-item label="机器编号" prop="robotCode">
                    <el-input v-model="addForm.robotCode" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="站点ID" prop="stationId">
                    <el-input v-model="addForm.stationId" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="楼宇ID" prop="buildingId">
                    <el-input v-model="addForm.buildingId" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="出发点ID" prop="homePoiId">
                    <el-input v-model="addForm.homePoiId" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="启用状态">
                    <el-radio-group v-model="addForm.enabled">
                        <el-radio class="radio" :label="true">启用</el-radio>
                        <el-radio class="radio" :label="false">停用</el-radio>
                    </el-radio-group>
                </el-form-item>
                <el-form-item label="可充电">
                    <el-radio-group v-model="addForm.rechargeable">
                        <el-radio class="radio" :label="true">是</el-radio>
                        <el-radio class="radio" :label="false">否</el-radio>
                    </el-radio-group>
                </el-form-item>
                <el-form-item label="至工位">
                    <el-radio-group v-model="addForm.innerUse">
                        <el-radio class="radio" :label="true">是</el-radio>
                        <el-radio class="radio" :label="false">否</el-radio>
                    </el-radio-group>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click.native="addFormVisible = false">取消</el-button>
                <el-button type="primary" @click.native="addSubmit">提交</el-button>
            </div>
        </el-dialog>

        <!--编辑界面-->
        <el-dialog title="编辑" :visible.sync="editFormVisible" :close-on-click-modal="false">
            <el-form :model="editForm" label-width="80px" :rules="editFormRules" ref="editForm">
                <el-form-item label="机器编号" prop="robotCode">
                    <el-input v-model="editForm.robotCode" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="站点ID" prop="stationId">
                    <el-input v-model="editForm.stationId" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="楼宇ID" prop="buildingId">
                    <el-input v-model="editForm.buildingId" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="出发点ID" prop="homePoiId">
                    <el-input v-model="editForm.homePoiId" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="启用状态">
                    <el-radio-group v-model="editForm.enabled">
                        <el-radio class="radio" :label="true">启用</el-radio>
                        <el-radio class="radio" :label="false">停用</el-radio>
                    </el-radio-group>
                </el-form-item>
                <el-form-item label="可充电">
                    <el-radio-group v-model="editForm.rechargeable">
                        <el-radio class="radio" :label="true">是</el-radio>
                        <el-radio class="radio" :label="false">否</el-radio>
                    </el-radio-group>
                </el-form-item>
                <el-form-item label="至工位">
                    <el-radio-group v-model="editForm.innerUse">
                        <el-radio class="radio" :label="true">是</el-radio>
                        <el-radio class="radio" :label="false">否</el-radio>
                    </el-radio-group>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click.native="editFormVisible = false">取消</el-button>
                <el-button type="primary" @click.native="editSubmit">提交</el-button>
            </div>
        </el-dialog>
    </section>
</template>

<script>
  import Webapi from '../api/webapi';
  import {formatDate} from "../common/date";

  export default {
    data() {
      return {
        filters: {
          name: 'robot_code:Like'
        },
        dataList: [],
        total: 0,
        page: 1,
        listLoading: false,

        addFormVisible: false,
        addFormRules: {
          robotCode: [
            {required: true, message: '请输入机器人编码', trigger: 'blur'}
          ],
          stationId: [
            {required: true, message: '请输入站点ID', trigger: 'blur'}
          ],
          buildingId: [
            {required: true, message: '请输入楼宇ID', trigger: 'blur'}
          ],
          homePoiId: [
            {required: true, message: '请输入出发点ID', trigger: 'blur'}
          ]
        },
        addForm: {},

        editFormVisible: false,
        editFormRules: {
          robotCode: [
            {required: true, message: '请输入机器人编码', trigger: 'blur'}
          ],
          stationId: [
            {required: true, message: '请输入站点ID', trigger: 'blur'}
          ],
          buildingId: [
            {required: true, message: '请输入楼宇ID', trigger: 'blur'},
          ],
          homePoiId: [
            {required: true, message: '请输入出发点ID', trigger: 'blur'}
          ]
        },
        editForm: {},

        cabinetTableVisible: false,
        cabinetList: []
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
        Webapi.listUser(params).then(
          res => {
            this.listLoading = false;
            if (res.data && res.data.data) {
              this.dataList = res.data.data.list;
              this.total = res.data.data.total;
            }
          }
        );
      },
      handleEdit() {

      },
      handleAdd() {

      }
    }
  }
</script>

<style scoped>
    .el-input .el-select {
        width: 120px;
    }
</style>
