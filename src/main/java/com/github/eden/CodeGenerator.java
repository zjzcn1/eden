package com.github.eden;


import cn.hutool.core.date.DateUtil;
import cn.hutool.core.io.FileUtil;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.*;
import java.util.concurrent.TimeUnit;

@Slf4j
public class CodeGenerator {

    private Config config;
    private DbConnection connection;
    private TemplateEngine engine;

    public CodeGenerator(Config config) {
        this.config = config;
        connection = new DbConnection(config);
        engine = new TemplateEngine();
    }

    public void generateCode() {
        String projectPath = Utils.getRootPath() + "project/" + config.getProjectName() + "-" + DateUtil.format(new Date(), "yyyyMMdd-HHmmss");
        String javaPath = projectPath + "/src/main/java/";
        String resourcePath = projectPath + "/src/main/resources/";
        String packageName = config.getPackageName();

        FileUtil.copy(Utils.getRootPath() + "/src/main/resources/webui", projectPath, true);

        List<TableInfo> tableInfos = new ArrayList<>();
        List<String> tables = connection.getTables();
        for (String table : tables) {
            TableInfo info = new TableInfo();
            info.setClassName(table);
            info.setTableComment(connection.getCommentByTableName(table));
            info.setClassName(Utils.toClassName(table));
            info.setObjectName(Utils.toObjectName(table));
            tableInfos.add(info);

            List<TableColumn> columns = connection.getColumns(table);
            // Controller
            Map<String, Object> controllerParam = ParamBuilder.buildParam(packageName, table, columns);
            String controller = engine.render("Controller.java.ftl", controllerParam);
            String controllerFile = javaPath + ParamBuilder.buildControllerFileName(packageName, table);
            Utils.writeFile(controllerFile, controller);

            // Service
            Map<String, Object> param = ParamBuilder.buildParam(packageName, table, columns);
            String service = engine.render("Service.java.ftl", param);
            String serviceFile = javaPath + ParamBuilder.buildServiceFileName(packageName, table);
            Utils.writeFile(serviceFile, service);

            // ServiceImpl
            String serviceImpl = engine.render("ServiceImpl.java.ftl", param);
            String serviceImplFile = javaPath + ParamBuilder.buildServiceImplFileName(packageName, table);
            Utils.writeFile(serviceImplFile, serviceImpl);

            // Dao
            String dao = engine.render("Dao.java.ftl", param);
            String daoFile = javaPath + ParamBuilder.buildDaoFileName(packageName, table);
            Utils.writeFile(daoFile, dao);

            // Entity
            String entity = engine.render("Entity.java.ftl", param);
            String entityFile = javaPath + ParamBuilder.buildEntityFileName(packageName, table);
            Utils.writeFile(entityFile, entity);

            // Mapper
            String mapper = engine.render("Mapper.xml.ftl", param);
            String mapperFile = resourcePath + ParamBuilder.buildMapperFileName(packageName, table);
            Utils.writeFile(mapperFile, mapper);

            // UI
            Map<String, Object> viewParams = new HashMap<>();
            viewParams.put("columns", columns);
            viewParams.put("table", info);
            String view = engine.render("webui/View.vue.ftl", viewParams);
            String viewFile = projectPath + "/webui/" + ParamBuilder.buildViewFileName(packageName, table);
            Utils.writeFile(viewFile, view);
        }

        Map<String, Object> param= new HashMap<>();
        param.put("packageName", packageName);
        param.put("projectName", config.getProjectName());
        // ErrorCode.java
        String errorCode = engine.render("common/ErrorCode.java.ftl", param);
        String errorCodeFile = javaPath + ParamBuilder.buildCommonPath(packageName) + "ErrorCode.java";
        Utils.writeFile(errorCodeFile, errorCode);

        // ExceptionHandler.java
        String exceptionHandler = engine.render("common/ExceptionHandler.java.ftl", param);
        String exceptionHandlerFile = javaPath + ParamBuilder.buildCommonPath(packageName) + "ExceptionHandler.java";
        Utils.writeFile(exceptionHandlerFile, exceptionHandler);

        // Page.java
        String page = engine.render("common/Page.java.ftl", param);
        String pageFile = javaPath + ParamBuilder.buildCommonPath(packageName) + "Page.java";
        Utils.writeFile(pageFile, page);

        // Page.java
        String pageable = engine.render("common/Pageable.java.ftl", param);
        String pageableFile = javaPath + ParamBuilder.buildCommonPath(packageName) + "Pageable.java";
        Utils.writeFile(pageableFile, pageable);

        // PagePlugin.java
        String pagePlugin = engine.render("common/PagePlugin.java.ftl", param);
        String pagePluginFile = javaPath + ParamBuilder.buildCommonPath(packageName) + "PagePlugin.java";
        Utils.writeFile(pagePluginFile, pagePlugin);

        // PagePlugin.java
        String result = engine.render("common/Result.java.ftl", param);
        String resultFile = javaPath + ParamBuilder.buildCommonPath(packageName) + "Result.java";
        Utils.writeFile(resultFile, result);

        // ServiceException.java
        String serviceException = engine.render("common/ServiceException.java.ftl", param);
        String serviceExceptionFile = javaPath + ParamBuilder.buildCommonPath(packageName) + "ServiceException.java";
        Utils.writeFile(serviceExceptionFile, serviceException);

        // CorsConfig.java
        String corsConfig = engine.render("config/CorsConfig.java.ftl", param);
        String corsConfigFile = javaPath + ParamBuilder.buildConfigPath(packageName) + "CorsConfig.java";
        Utils.writeFile(corsConfigFile, corsConfig);

        // SpringConfig.java
        String springConfig = engine.render("config/SpringConfig.java.ftl", param);
        String springConfigFile = javaPath + ParamBuilder.buildConfigPath(packageName) + "SpringConfig.java";
        Utils.writeFile(springConfigFile, springConfig);

        // Application.java
        String application = engine.render("Application.java.ftl", param);
        String applicationFile = javaPath + ParamBuilder.buildBasePackagePath(packageName) + "Application.java";
        Utils.writeFile(applicationFile, application);

        // application.properties
        String applicationProp = engine.render("application.properties.ftl", param);
        String applicationPropFile = projectPath + "/config/application.properties";
        Utils.writeFile(applicationPropFile, applicationProp);

        // application-dev.properties
        param.put("applicationMain", packageName + ".Application");
        param.put("dbDriverClass", config.getDbDriverClass());
        param.put("dbUrl", config.getDbUrl());
        param.put("dbUsername", config.getDbUsername());
        param.put("dbPassword", config.getDbPassword());
        String applicationDevProp = engine.render("application-dev.properties.ftl", param);
        String applicationDevPropFile = projectPath + "/config/application-dev.properties";
        Utils.writeFile(applicationDevPropFile, applicationDevProp);

        // application-prod.properties
        String applicationProdProp = engine.render("application-prod.properties.ftl", param);
        String applicationProdPropFile = projectPath + "/config/application-prod.properties";
        Utils.writeFile(applicationProdPropFile, applicationProdProp);

        // assembly.xml
        String assembly = engine.render("release.xml.ftl", param);
        String assemblyFile = projectPath + "/release.xml";
        Utils.writeFile(assemblyFile, assembly);

        // pom.xml
        String pom = engine.render("pom.xml.ftl", param);
        String pomFile = projectPath + "/pom.xml";
        Utils.writeFile(pomFile, pom);

        // start.sh
        String start = engine.render("start.sh.ftl", param);
        String startFile = projectPath + "/bin/start.sh";
        Utils.writeFile(startFile, start);

        // webapi
        Map<String, Object> webapiParams = new HashMap<>();
        webapiParams.put("tables", tableInfos);
        String webapi = engine.render("webui/webapi.js.ftl", webapiParams);
        String webapiFile = projectPath + "/webui/src/webapi.js";
        Utils.writeFile(webapiFile, webapi);

        // ui routes
        String routes = engine.render("webui/routes.js.ftl", webapiParams);
        String routesFile = projectPath + "/webui/src/routes.js";
        Utils.writeFile(routesFile, routes);

        // ui Main.vue
        Map<String, Object> mainUiParams = new HashMap<>();
        mainUiParams.put("systemName", config.getSystemName());
        String mainUi = engine.render("webui/Main.vue.ftl", mainUiParams);
        String mainUiFile = projectPath + "/webui/src/views/Main.vue";
        Utils.writeFile(mainUiFile, mainUi);
        // ui index.html
        Map<String, Object> indexParams = new HashMap<>();
        indexParams.put("systemName", config.getSystemName());
        String indexUi = engine.render("webui/index.html.ftl", indexParams);
        String indexUiFile = projectPath + "/webui/index.html";
        Utils.writeFile(indexUiFile, indexUi);
    }

}
