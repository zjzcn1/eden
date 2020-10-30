<template>
    <el-container class="container">
        <header class="header-container">
            <el-col :span="10" class="logo">
                <img class="icon" src="../assets/logo.png"/>
                <span class="text">${systemName}</span>
            </el-col>
            <el-col :span="10" class="tool">

            </el-col>
            <el-col :span="4" class="user">
                <span>
                    <i class="el-icon-user-solid"></i>
                    {{userName}}
                </span>
            </el-col>
        </header>
        <div :span="24" class="body-container">
            <aside class="sidebar-container">
                <el-menu :default-active="$route.path" unique-opened router>
                    <template v-for="(item, index) in $router.options.routes">
                        <el-submenu :index="item.path + index" v-if="!item.meta.hidden&&!item.meta.leaf" :key="index">
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
                <el-breadcrumb separator="/">
                    <i :class="$route.meta.icon"></i>
                    <template v-for="(item, index) in $route.meta.breadcrumb ? $route.meta.breadcrumb : $route.matched">
                        <el-breadcrumb-item :key="index">
                            {{ item.name }}
                        </el-breadcrumb-item>
                    </template>
                </el-breadcrumb>
                <el-main>
                    <transition name="fade" mode="out-in">
                        <router-view v-if="isRouterAlive" :msg="currentApp"></router-view>
                    </transition>
                </el-main>
            </div>
        </div>
    </el-container>
</template>

<script>

  // import Webapi from '../common/webapi'

  export default {
    data() {
      return {
        isRouterAlive: true,
        userName: ''
      }
    },
    mounted() {
      setTimeout(() => {
        this.currentApp = 2;
        this.refresh();
      }, 3000);
      // Webapi.getDemo()
    },
    methods: {
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

    $header-color: #373d41;
    $header-height: 50px;
    $sidebar-width: 220px;
    $sidebar-collapse-width: 64px;
    $breadcrumb-height: 42px;

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

        .header-container {
            background-color: $header-color;
            color: #fff;
            line-height: $header-height;
            height: $header-height;
            width: 100%;

            .logo {
                width: $sidebar-width;
                height: $header-height;
                font-size: 18px;
                padding-left: 12px;
                padding-right: 20px;
                border-right: 1px solid rgba(238, 241, 146, 0.3);

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
                .app-select {
                    margin-left: 12px;

                    .el-input__inner {
                        border-radius: 2px;
                        width: 200px;
                    }
                }
            }

            .user {
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

                width: $sidebar-width;
                z-index: 200;
                .el-menu {
                    height: 100%;

                    .icon {
                        margin-right: 8px;
                    }
                }
            }

            .content-container {
                background: #f3f3f3;
                flex: 1;
                overflow-x: auto;

                .el-breadcrumb {
                    box-shadow: 0 1px 2px 0 rgba(0, 0, 0, .1);
                    padding: 0 14px;
                    height: $breadcrumb-height;
                    line-height: $breadcrumb-height;
                    i {
                        font-size: 14px;
                        color: #909399;
                        float: left;
                        margin-right: 8px;
                    }
                }

                .el-main {
                    @include scrollbar;

                    height: calc(100vh - ${r"#{"}$header-height${r"}"} - ${r"#{"}$breadcrumb-height${r"}"});
                    margin-top: 1px;
                    padding: 20px 12px;
                    box-sizing: border-box;

                    .query-bar {
                        margin-left: 16px;
                        .el-form-item {
                            margin-right: 20px;
                        }
                        .el-input {
                            width: 120px;
                        }
                    }
                }
            }
        }
    }

</style>
