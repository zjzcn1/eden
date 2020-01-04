<template>
    <el-container class="container">
        <header class="header">
            <el-col :span="10" class="logo" :class="collapsed?'logo-collapse-width':'logo-width'">
                <img class="icon" src="../assets/logo.png"/>
                {{collapsed?sysShortName:sysName}}
            </el-col>
            <el-col :span="10">
                <div class="tool" @click.prevent="collapse">
                    <i class="fa fa-align-justify"></i>
                </div>
            </el-col>
            <el-col :span="4" class="user">
                <el-dropdown trigger="click">
                    <span class="el-dropdown-link">{{sysUserName}}<i class="el-icon-caret-bottom"></i></span>
                    <el-dropdown-menu slot="dropdown">
                        <el-dropdown-item @click.native="logout">退出登录</el-dropdown-item>
                    </el-dropdown-menu>
                </el-dropdown>
            </el-col>
        </header>
        <div :span="24" class="content-container">
            <aside class="sidebar" :class="collapsed?'sidebar-collapse-width':'sidebar-width'">
                <!--导航菜单-->
                <el-menu :default-active="$route.path" class="el-menu-vertical-demo" :unique-opened="true" router
                         :collapse="collapsed">
                    <template v-for="(item,index) in $router.options.routes">
                        <el-submenu :index="index+''" v-if="!item.leaf && !item.hidden" :key="index">
                            <template slot="title">
                                <i :class="item.icon"></i>
                                <span slot="title">{{item.name}}</span>
                            </template>
                            <template v-for="child in item.children">
                                <el-menu-item :index="child.path" :key="child.path" v-if="!child.hidden">
                                    <template slot="title">
                                        <i :class="child.icon"></i>
                                        <span slot="title">{{child.name}}</span>
                                    </template>
                                </el-menu-item>
                            </template>
                        </el-submenu>
                        <el-menu-item v-if="item.leaf && item.children.length>0 && !item.hidden"
                                      :index="item.children[0].path" :key="index">
                            <i :class="item.icon"></i>
                            <span slot="title">{{item.children[0].name}}</span>
                        </el-menu-item>
                    </template>
                </el-menu>
            </aside>
            <div :span="24" class="main-container">
                <el-breadcrumb separator="/">
                    <el-breadcrumb-item v-for="item in $route.matched" :key="item.path">
                        {{ item.name }}
                    </el-breadcrumb-item>
                </el-breadcrumb>
                <el-main>
                    <transition name="fade" mode="out-in">
                        <router-view></router-view>
                    </transition>
                </el-main>
            </div>
        </div>
    </el-container>
</template>

<script>

  export default {
    data() {
      return {
        sysName: '${systemName}',
        sysShortName: '',
        collapsed: false,
        sysUserName: ''
      }
    },
    methods: {
      //退出登录
      logout() {
        this.$confirm('确认退出吗?', '提示', {
          type: 'warning'
        }).then(() => {

        }).catch(() => {

        });
      },
      //折叠导航栏
      collapse() {
        this.collapsed = !this.collapsed;
      }
    },
    mounted() {
      // Webapi.getCurrentUser().then((res) => {
      //   if (res.data && res.data.code === 200) {
      //     this.sysUserName = res.data.data.userName;
      //   }
      // });
    }
  }

</script>

<style scoped lang="scss">
    $header-color: #16222b;
    $header-height: 50px;
    $sidebar-width: 220px;
    $sidebar-collapse-width: 64px;

    .container {
        position: absolute;
        top: 0px;
        bottom: 0px;
        width: 100%;
        .header {
            background-color: $header-color;
            color: #fff;
            line-height: $header-height;
            height: $header-height;
            width: 100%;
            .logo {
                height: $header-height;
                font-size: 20px;
                padding-left: 12px;
                padding-right: 20px;
                border-right: 1px solid rgba(238, 241, 146, 0.3);
                i {
                    font-size: 28px;
                    margin: 10px 10px 10px 0px;
                    float: left;
                }
                .icon {
                    height: 28px;
                    width: 28px;
                    margin: 10px 10px 10px 0px;
                    float: left;
                }
            }
            .logo-width {
                width: $sidebar-width;
            }
            .logo-collapse-width {
                width: $sidebar-collapse-width;
            }
            .tool {
                padding: 0px 23px;
                width: 14px;
                cursor: pointer;
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
        .content-container {
            width: 100%;
            display: flex;
            position: absolute;
            top: $header-height;
            bottom: 0px;
            overflow: hidden;
            .sidebar {
                overflow-y: auto;
                overflow-x: hidden;
                z-index: 200;
                &::-webkit-scrollbar {
                    width: 6px;
                    background-color: #cfd5de;
                }
                &::-webkit-scrollbar-thumb {
                    background: #8b939e;
                }
                .el-menu {
                    height: 100%;
                }
            }
            .sidebar-width {
                width: $sidebar-width;
            }
            .sidebar-collapse-width {
                overflow-y: visible;
                overflow-x: visible;
                width: $sidebar-collapse-width;
            }

            .main-container {
                background: #fafafa;
                flex: 1;
                overflow-y: auto;
                overflow-x: hidden;
                &::-webkit-scrollbar {
                    width: 6px;
                    background-color: #cfd5de;
                }
                &::-webkit-scrollbar-thumb {
                    background: #8b939e;
                }
                .el-breadcrumb {
                    box-shadow: 0 1px 2px 0 rgba(0, 0, 0, .1);
                    padding: 15px;
                    .title {
                        width: 200px;
                        float: left;
                        color: #475669;
                    }
                }
                .el-main {
                    margin-top: 0px;
                    padding: 15px;
                    box-sizing: border-box;
                }
            }
        }
    }

</style>
