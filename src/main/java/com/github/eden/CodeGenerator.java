package com.github.eden;


import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.time.DateFormatUtils;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    public void generateCode() throws IOException {
        log.info("Starting generate code...");
        String projectPath = EdenUtils.getRootPath() + "project/" + config.getProjectName() + "-" + DateFormatUtils.format(new Date(), "yyyyMMdd-HHmmss");
        String javaPath = projectPath + "/src/main/java/";
        String resourcePath = projectPath + "/src/main/resources/";
        String packageName = config.getPackageName();

        EdenUtils.copyResources("webui/", projectPath);

        List<TableInfo> tableInfos = new ArrayList<>();
        List<String> tables = connection.getTables();
        for (String tableName : tables) {
            TableInfo table = new TableInfo();
            table.setTableName(tableName);
            table.setTableComment(connection.getCommentByTableName(tableName));
            table.setClassName(EdenUtils.toBigCamelCase(tableName));
            table.setObjectName(EdenUtils.toCamelCase(tableName));
            tableInfos.add(table);

            List<TableColumn> columns = connection.getColumns(tableName);
            // Controller
            Map<String, Object> controllerParam = ParamBuilder.buildParam(packageName, table, columns);
            String controller = engine.render("backend/Controller.java.ftl", controllerParam);
            String controllerFile = javaPath + ParamBuilder.buildControllerFileName(packageName, table);
            FileUtils.write(new File(controllerFile), controller, "UTF-8");

            // Service
            Map<String, Object> param = ParamBuilder.buildParam(packageName, table, columns);
            String service = engine.render("backend/Service.java.ftl", param);
            String serviceFile = javaPath + ParamBuilder.buildServiceFileName(packageName, table);
            FileUtils.write(new File(serviceFile), service, "UTF-8");

            // Dao
            String dao = engine.render("backend/Dao.java.ftl", param);
            String daoFile = javaPath + ParamBuilder.buildDaoFileName(packageName, table);
            FileUtils.write(new File(daoFile), dao, "UTF-8");

            // Entity
            String entity = engine.render("backend/Entity.java.ftl", param);
            String entityFile = javaPath + ParamBuilder.buildEntityFileName(packageName, table);
            FileUtils.write(new File(entityFile), entity, "UTF-8");

            // Mapper
            String mapper = engine.render("backend/Mapper.xml.ftl", param);
            String mapperFile = resourcePath + ParamBuilder.buildMapperFileName(packageName, table);
            FileUtils.write(new File(mapperFile), mapper, "UTF-8");

            // UI
            Map<String, Object> viewParams = new HashMap<>();
            viewParams.put("columns", columns);
            viewParams.put("table", table);
            String view = engine.render("frontend/View.vue.ftl", viewParams);
            String viewFile = projectPath + "/webui/" + ParamBuilder.buildViewFileName(packageName, table);
            FileUtils.write(new File(viewFile), view, "UTF-8");
        }

        Map<String, Object> param= new HashMap<>();
        param.put("packageName", packageName);
        param.put("projectName", config.getProjectName());
        // ErrorCode.java
        String errorCode = engine.render("backend/common/ErrorCode.java.ftl", param);
        String errorCodeFile = javaPath + ParamBuilder.buildCommonPath(packageName) + "ErrorCode.java";
        FileUtils.write(new File(errorCodeFile), errorCode, "UTF-8");

        // ExceptionHandler.java
        String exceptionHandler = engine.render("backend/common/ExceptionHandler.java.ftl", param);
        String exceptionHandlerFile = javaPath + ParamBuilder.buildCommonPath(packageName) + "ExceptionHandler.java";
        FileUtils.write(new File(exceptionHandlerFile), exceptionHandler, "UTF-8");

        // Page.java
        String page = engine.render("backend/common/Page.java.ftl", param);
        String pageFile = javaPath + ParamBuilder.buildCommonPath(packageName) + "Page.java";
        FileUtils.write(new File(pageFile), page, "UTF-8");

        // Pageable.java
        String pageable = engine.render("backend/common/Pageable.java.ftl", param);
        String pageableFile = javaPath + ParamBuilder.buildCommonPath(packageName) + "Pageable.java";
        FileUtils.write(new File(pageableFile), pageable, "UTF-8");

        // PagePlugin.java
        String pagePlugin = engine.render("backend/common/PagePlugin.java.ftl", param);
        String pagePluginFile = javaPath + ParamBuilder.buildCommonPath(packageName) + "PagePlugin.java";
        FileUtils.write(new File(pagePluginFile), pagePlugin, "UTF-8");

        // PagePlugin.java
        String result = engine.render("backend/common/Result.java.ftl", param);
        String resultFile = javaPath + ParamBuilder.buildCommonPath(packageName) + "Result.java";
        FileUtils.write(new File(resultFile), result, "UTF-8");

        // ServiceException.java
        String serviceException = engine.render("backend/common/ServiceException.java.ftl", param);
        String serviceExceptionFile = javaPath + ParamBuilder.buildCommonPath(packageName) + "ServiceException.java";
        FileUtils.write(new File(serviceExceptionFile), serviceException, "UTF-8");

        // CorsConfig.java
        String corsConfig = engine.render("backend/config/CorsConfig.java.ftl", param);
        String corsConfigFile = javaPath + ParamBuilder.buildConfigPath(packageName) + "CorsConfig.java";
        FileUtils.write(new File(corsConfigFile), corsConfig, "UTF-8");

        // SpringConfig.java
        String springConfig = engine.render("backend/config/SpringConfig.java.ftl", param);
        String springConfigFile = javaPath + ParamBuilder.buildConfigPath(packageName) + "SpringConfig.java";
        FileUtils.write(new File(springConfigFile), springConfig, "UTF-8");

        // Application.java
        String application = engine.render("backend/Application.java.ftl", param);
        String applicationFile = javaPath + ParamBuilder.buildBasePackagePath(packageName) + "Application.java";
        FileUtils.write(new File(applicationFile), application, "UTF-8");

        // application.properties
        String applicationProp = engine.render("backend/application.properties.ftl", param);
        String applicationPropFile = projectPath + "/config/application.properties";
        FileUtils.write(new File(applicationPropFile), applicationProp, "UTF-8");

        // application-dev.properties
        param.put("applicationMain", packageName + ".Application");
        param.put("dbDriverClass", config.getDbDriverClass());
        param.put("dbUrl", config.getDbUrl());
        param.put("dbUsername", config.getDbUsername());
        param.put("dbPassword", config.getDbPassword());
        String applicationDevProp = engine.render("backend/application-dev.properties.ftl", param);
        String applicationDevPropFile = projectPath + "/config/application-dev.properties";
        FileUtils.write(new File(applicationDevPropFile), applicationDevProp, "UTF-8");

        // application-prod.properties
        String applicationProdProp = engine.render("backend/application-prod.properties.ftl", param);
        String applicationProdPropFile = projectPath + "/config/application-prod.properties";
        FileUtils.write(new File(applicationProdPropFile), applicationProdProp, "UTF-8");

        // assembly.xml
        String assembly = engine.render("backend/release.xml.ftl", param);
        String assemblyFile = projectPath + "/release.xml";
        FileUtils.write(new File(assemblyFile), assembly, "UTF-8");

        // pom.xml
        String pom = engine.render("backend/pom.xml.ftl", param);
        String pomFile = projectPath + "/pom.xml";
        FileUtils.write(new File(pomFile), pom, "UTF-8");

        // start.sh
        String startSh = engine.render("backend/start.sh.ftl", param);
        String startShFile = projectPath + "/bin/start.sh";
        FileUtils.write(new File(startShFile), startSh, "UTF-8");

        // webapi
        Map<String, Object> webapiParams = new HashMap<>();
        webapiParams.put("tables", tableInfos);
        String webapi = engine.render("frontend/webapi.js.ftl", webapiParams);
        String webapiFile = projectPath + "/webui/src/webapi.js";
        FileUtils.write(new File(webapiFile), webapi, "UTF-8");

        // ui routes
        String routes = engine.render("frontend/routes.js.ftl", webapiParams);
        String routesFile = projectPath + "/webui/src/routes.js";
        FileUtils.write(new File(routesFile), routes, "UTF-8");

        // ui Main.vue
        Map<String, Object> mainUiParams = new HashMap<>();
        mainUiParams.put("systemName", config.getSystemName());
        String mainUi = engine.render("frontend/Main.vue.ftl", mainUiParams);
        String mainUiFile = projectPath + "/webui/src/views/Main.vue";
        FileUtils.write(new File(mainUiFile), mainUi, "UTF-8");
        // ui index.html
        Map<String, Object> indexParams = new HashMap<>();
        indexParams.put("systemName", config.getSystemName());
        String indexUi = engine.render("frontend/index.html.ftl", indexParams);
        String indexUiFile = projectPath + "/webui/index.html";
        FileUtils.write(new File(indexUiFile), indexUi, "UTF-8");

        log.info("Finish generate code.");
    }

}
