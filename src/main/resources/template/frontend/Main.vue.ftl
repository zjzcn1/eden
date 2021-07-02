<template>
    <el-container class="container">
        <header class="header-container">
            <el-col :span="10" class="logo" :class="collapsed?'sidebar-collapse-width':'sidebar-width'">
                <img class="icon" src="../assets/logo.png"/>
                <span class="text">{{collapsed ? '' : '${systemName}'}}</span>
            </el-col>
            <el-col :span="10" class="tool">
                <div @click.prevent="collapse" class="tool-item">
                    <i style="font-size: 18px;" :class="[collapsed ? 'el-icon-s-unfold' : 'el-icon-s-fold']"></i>
                </div>
                <div @click.prevent="refresh" class="tool-item">
                    <i style="font-size: 18px;"  class="el-icon-refresh"></i>
                </div>
                <el-breadcrumb separator="/">
                    <template v-for="(item, index) in $route.meta.breadcrumb ? $route.meta.breadcrumb : $route.matched">
                        <el-breadcrumb-item :key="index" :to="item.path">
                            {{ item.name }}
                        </el-breadcrumb-item>
                    </template>
                </el-breadcrumb>
            </el-col>
            <el-col :span="4" class="user">
                <span>
                    <i class="el-icon-user-solid"></i>
                    {{username}}
                </span>
            </el-col>
        </header>
        <div :span="24" class="body-container">
            <aside class="sidebar-container" :class="collapsed?'sidebar-collapse-width':'sidebar-width'">
                <el-menu :default-active="$route.path" unique-opened router :collapse="collapsed" :collapse-transition="false">
                    <template v-for="(item, index) in $router.options.routes">
                        <el-submenu :index="item.path + index" :key="index"
                                    v-if="!item.meta.hidden&&!item.meta.leaf">
                            <template slot="title">
                                <i class="icon" :class="item.meta.icon"></i>
                                <span slot="title">{{item.name}}</span>
                            </template>
                            <template v-for="child in item.children">
                                <el-menu-item :index="child.path" :key="child.path"
                                              v-if="!child.meta.hidden">
                                    <template slot="title">
                                        <i class="icon" :class="child.meta.icon"></i>
                                        <span slot="title">{{child.name}}</span>
                                    </template>
                                </el-menu-item>
                            </template>
                        </el-submenu>
                        <el-menu-item v-if="!item.meta.hidden&&item.meta.leaf&&item.children.length>0"
                                      :index="item.children[0].path" :key="index">
                            <i class="icon" :class="item.children[0].meta.icon"></i>
                            <span slot="title">{{item.children[0].name}}</span>
                        </el-menu-item>
                    </template>
                </el-menu>
            </aside>
            <div :span="24" class="content-container">
                <el-main>
                    <transition name="fade" mode="out-in">
                        <router-view v-if="isRouterAlive"></router-view>
                    </transition>
                </el-main>
            </div>
        </div>
    </el-container>
</template>

<script>

  // import webapi from '../common/webapi'

  export default {
    data() {
      return {
        collapsed: false,
        isRouterAlive: true,
        username: ''
      }
    },
    mounted() {
      setTimeout(() => {
        this.currentApp = 2;
        this.refresh();
      }, 3000);
      // webapi.getDemo()
    },
    methods: {
      collapse(){
        this.collapsed=!this.collapsed;
      },
      refresh() {
        this.isRouterAlive = false;
        this.$nextTick(() => {
          this.isRouterAlive = true;
        })
      }
    }
  }

</script>

<style lang="scss">
    @import '../assets/iconfont/iconfont.css';

    $sidebar-background-color: #1c1e2f;
    $header-height: 56px;
    $sidebar-width: 220px;
    $sidebar-collapse-width: 65px;

    @mixin scrollbar() {
        overflow-y: auto;
        overflow-x: hidden;
        &::-webkit-scrollbar {
            width: 6px;
            background-color: #cfd5de;
        }

        &::-webkit-scrollbar-thumb {
            background: #8b939e;
        }
    }

    .container {
        position: absolute;
        top: 0px;
        bottom: 0px;
        width: 100%;
        height: 100%;

        .sidebar-width {
            width: $sidebar-width;
        }
        .sidebar-collapse-width{
            width: $sidebar-collapse-width;
        }
        .header-container {
            color: #fff;
            line-height: $header-height;
            height: $header-height - 1;
            width: 100%;
            box-shadow: 0 1px 0 0 rgba(0, 0, 0, 0.1);

            .logo {
                background-color: $sidebar-background-color;
                height: $header-height;
                font-size: 18px;
                padding-left: 4px;
                padding-right: 20px;
                border-right: solid 1px #e6e6e6;

                .icon {
                    height: 30px;
                    width: 30px;
                    margin: 10px;
                    float: left;
                }

                .text {
                    font-weight: 500;
                }
            }

            .tool {
                padding-left: 8px;
                .tool-item {
                    padding: 0px 12px;
                    width:14px;
                    cursor: pointer;
                    color: #595959;
                    float: left;
                }
                .el-breadcrumb {
                    padding: 0 14px;
                    height: $header-height;
                    line-height: $header-height;

                    i {
                        font-size: 14px;
                        color: #909399;
                        float: left;
                        margin-right: 8px;
                    }

                    .back-button {
                        float: right;
                        margin: 5px 15px;
                    }
                }
            }

            .user {
                color: #595959;
                text-align: right;
                padding-right: 35px;
                float: right;

                .el-dropdown-link {
                    cursor: pointer;
                    color: #fff;
                }
            }
        }

        .body-container {
            width: 100%;
            display: flex;
            position: absolute;
            top: $header-height;
            bottom: 0px;

            .sidebar-container {
                @include scrollbar;

                z-index: 200;

                .el-menu {
                    height: 100%;
                    background-color: $sidebar-background-color;

                    .icon {
                        margin-right: 8px;
                    }

                    .el-menu-item, .el-submenu__title {
                        background-color: $sidebar-background-color;
                        color: #ffffff;
                        height: 42px;
                        line-height: 42px;
                    }

                    .el-menu-item i, .el-submenu__title i {
                        color: #ffffff;
                    }

                    .el-menu-item.is-active {
                        background-color: #409eff;
                    }

                    .is-opened .el-menu-item:not(.is-active) {
                        background-color: #000c17;
                    }
                }
            }

            .content-container {
                background: #ffffff;
                flex: 1;
                overflow-x: auto;

                .el-main {
                    @include scrollbar;

                    height: calc(100vh - 1px - ${r"#{"}$header-height${r"}"});
                    margin-top: 1px;
                    padding: 0;
                    box-sizing: border-box;

                    .query-bar {
                        margin-left: 16px;

                        .el-form-item {
                            margin-right: 20px;
                        }
                    }

                    /*去掉表格单元格边框*/
                    .customer-no-border-table th {
                        border: none;
                    }

                    .customer-no-border-table td, .customer-no-border-table th.is-leaf {
                        border: none;
                    }

                    /*表格最外边框*/
                    .customer-no-border-table .el-table--border, .el-table--group {
                        border: none;
                    }

                    /*头部边框*/
                    .customer-no-border-table thead tr th.is-leaf {
                        border: 0px solid #EBEEF5;
                        border-right: none;
                    }

                    .customer-no-border-table thead tr th:nth-last-of-type(2) {
                        border-right: 0px solid #EBEEF5;
                    }
                }
            }
        }
    }

</style>
