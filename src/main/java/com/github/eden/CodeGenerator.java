package com.github.eden;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CodeGenerator {

    private static final Logger logger = LoggerFactory.getLogger(CodeGenerator.class);

    private Config config;
    private DbConnection connection;
    private TemplateEngine engine;

    public CodeGenerator(Config config) {
        this.config = config;
        connection = new DbConnection(config);
        engine = new TemplateEngine();
    }

    public void generateCode() {
        String projectPath = Utils.getRootPath() + "project/" + config.getProjectName();
        String javaPath = projectPath + "/src/main/java/";
        String resourcePath = projectPath + "/src/main/resources/";
        String packageName = config.getPackageName();

        List<String> tables = connection.getTables();
        for (String table : tables) {
            List<TableColumn> columns = connection.getColumns(table);
            // Controller
            Map<String, Object> controllerParam = ParamBuilder.buildParam(packageName, table, columns);
            String controller = engine.render("Controller.java.ftl", controllerParam);
            String controllerFile = javaPath + ParamBuilder.buildControllerFile(packageName, table);
            Utils.writeFile(controllerFile, controller);
            logger.info("Generate code to path: {}", controllerFile);

            // Service
            Map<String, Object> param = ParamBuilder.buildParam(packageName, table, columns);
            String service = engine.render("Service.java.ftl", param);
            String serviceFile = javaPath + ParamBuilder.buildServiceFile(packageName, table);
            Utils.writeFile(serviceFile, service);
            logger.info("Generate code to path: {}", serviceFile);

            // ServiceImpl
            String serviceImpl = engine.render("ServiceImpl.java.ftl", param);
            String serviceImplFile = javaPath + ParamBuilder.buildServiceImplFile(packageName, table);
            Utils.writeFile(serviceImplFile, serviceImpl);
            logger.info("Generate code to path: {}", serviceImplFile);

            // Dao
            String dao = engine.render("Dao.java.ftl", param);
            String daoFile = javaPath + ParamBuilder.buildDaoFile(packageName, table);
            Utils.writeFile(daoFile, dao);
            logger.info("Generate code to path: {}", daoFile);

            // Entity
            String entity = engine.render("Entity.java.ftl", param);
            String entityFile = javaPath + ParamBuilder.buildEntityFile(packageName, table);
            Utils.writeFile(entityFile, entity);
            logger.info("Generate code to path: {}", entityFile);

            // Mapper
            String mapper = engine.render("Mapper.xml.ftl", param);
            String mapperFile = resourcePath + ParamBuilder.buildMapperFile(packageName, table);
            Utils.writeFile(mapperFile, mapper);
            logger.info("Generate code to path: {}", mapperFile);
        }

        Map<String, Object> param= new HashMap<>();
        param.put("packageName", packageName);
        param.put("projectName", config.getProjectName());
        // ErrorCode.java
        String errorCode = engine.render("common/ErrorCode.java.ftl", param);
        String errorCodeFile = javaPath + ParamBuilder.buildCommonPath(packageName) + "ErrorCode.java";
        Utils.writeFile(errorCodeFile, errorCode);
        logger.info("Generate code to path: {}", errorCodeFile);

        // ExceptionHandler.java
        String exceptionHandler = engine.render("common/ExceptionHandler.java.ftl", param);
        String exceptionHandlerFile = javaPath + ParamBuilder.buildCommonPath(packageName) + "ExceptionHandler.java";
        Utils.writeFile(exceptionHandlerFile, exceptionHandler);
        logger.info("Generate code to path: {}", exceptionHandlerFile);

        // Page.java
        String page = engine.render("common/Page.java.ftl", param);
        String pageFile = javaPath + ParamBuilder.buildCommonPath(packageName) + "Page.java";
        Utils.writeFile(pageFile, page);
        logger.info("Generate code to path: {}", pageFile);

        // Page.java
        String pageable = engine.render("common/Pageable.java.ftl", param);
        String pageableFile = javaPath + ParamBuilder.buildCommonPath(packageName) + "Pageable.java";
        Utils.writeFile(pageableFile, pageable);
        logger.info("Generate code to path: {}", pageableFile);

        // PagePlugin.java
        String pagePlugin = engine.render("common/PagePlugin.java.ftl", param);
        String pagePluginFile = javaPath + ParamBuilder.buildCommonPath(packageName) + "PagePlugin.java";
        Utils.writeFile(pagePluginFile, pagePlugin);
        logger.info("Generate code to path: {}", pagePluginFile);

        // PagePlugin.java
        String result = engine.render("common/Result.java.ftl", param);
        String resultFile = javaPath + ParamBuilder.buildCommonPath(packageName) + "Result.java";
        Utils.writeFile(resultFile, result);
        logger.info("Generate code to path: {}", resultFile);

        // ServiceException.java
        String serviceException = engine.render("common/ServiceException.java.ftl", param);
        String serviceExceptionFile = javaPath + ParamBuilder.buildCommonPath(packageName) + "ServiceException.java";
        Utils.writeFile(serviceExceptionFile, serviceException);
        logger.info("Generate code to path: {}", serviceExceptionFile);

        // CorsConfig.java
        String corsConfig = engine.render("config/CorsConfig.java.ftl", param);
        String corsConfigFile = javaPath + ParamBuilder.buildConfigPath(packageName) + "CorsConfig.java";
        Utils.writeFile(corsConfigFile, corsConfig);
        logger.info("Generate code to path: {}", corsConfigFile);

        // SpringConfig.java
        String springConfig = engine.render("config/SpringConfig.java.ftl", param);
        String springConfigFile = javaPath + ParamBuilder.buildConfigPath(packageName) + "SpringConfig.java";
        Utils.writeFile(springConfigFile, springConfig);
        logger.info("Generate code to path: {}", springConfigFile);

        // Application.java
        String application = engine.render("Application.java.ftl", param);
        String applicationFile = javaPath + ParamBuilder.buildBasePackagePath(packageName) + "Application.java";
        Utils.writeFile(applicationFile, application);
        logger.info("Generate code to path: {}", applicationFile);

        // application.properties
        String applicationProp = engine.render("application.properties.ftl", param);
        String applicationPropFile = projectPath + "/config/application.properties";
        Utils.writeFile(applicationPropFile, applicationProp);
        logger.info("Generate code to path: {}", applicationPropFile);

        // application-dev.properties
        param.put("applicationMain", packageName + ".Application");
        param.put("dbDriverClass", config.getDbDriverClass());
        param.put("dbUrl", config.getDbUrl());
        param.put("dbUsername", config.getDbUsername());
        param.put("dbPassword", config.getDbPassword());
        String applicationDevProp = engine.render("application-dev.properties.ftl", param);
        String applicationDevPropFile = projectPath + "/config/application-dev.properties";
        Utils.writeFile(applicationDevPropFile, applicationDevProp);
        logger.info("Generate code to path: {}", applicationDevPropFile);
        // application-prod.properties
        String applicationProdProp = engine.render("application-prod.properties.ftl", param);
        String applicationProdPropFile = projectPath + "/config/application-prod.properties";
        Utils.writeFile(applicationProdPropFile, applicationProdProp);
        logger.info("Generate code to path: {}", applicationProdPropFile);

        // assembly.xml
        String assembly = engine.render("assembly.xml.ftl", param);
        String assemblyFile = projectPath + "/assembly.xml";
        Utils.writeFile(assemblyFile, assembly);
        logger.info("Generate code to path: {}", assemblyFile);

        // pom.xml
        String pom = engine.render("pom.xml.ftl", param);
        String pomFile = projectPath + "/pom.xml";
        Utils.writeFile(pomFile, pom);
        logger.info("Generate code to path: {}", pomFile);

        // start.sh
        String start = engine.render("start.sh.ftl", param);
        String startFile = projectPath + "/script/start.sh";
        Utils.writeFile(startFile, start);
        logger.info("Generate code to path: {}", startFile);
    }

}
