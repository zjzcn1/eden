package com.github.eden;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

public class CodeGenerator {

    private static final Logger logger = LoggerFactory.getLogger(CodeGenerator.class);

    private Config config;
    private DbConnection connection;
    private TemplateEngine engine;

    public CodeGenerator(Config config) {
        this.config = config;
        connection = new DbConnection(config.getDbUrl(), config.getDbUsername(), config.getDbPassword());
        engine = new TemplateEngine();
    }

    public void generateCode() {
        String projectPath = Utils.getRootPath() + config.getProjectName();
        String javaPath = projectPath + "/src/main/java/";
        String resPath = projectPath + "/src/main/resources/";

        List<String> tables = connection.getTables();
        for (String table : tables) {
            List<TableColumn> columns = connection.getColumns(table);

            Param param = new Param(config.getPackageName(), table, columns);
            String controller = engine.render("Controller.java.ftl", param);
            String service = engine.render("Service.java.ftl", param);
            String serviceImpl = engine.render("ServiceImpl.java.ftl", param);
            String dao = engine.render("Dao.java.ftl", param);
            String entity = engine.render("Entity.java.ftl", param);
            String mapper = engine.render("Mapper.xml.ftl", param);

            String controllerPath = javaPath + Utils.packageToPath(param.getControllerPackageName());
            String servicePath = javaPath + Utils.packageToPath(param.getServicePackageName());
            String serviceImplPath = javaPath + Utils.packageToPath(param.getServiceImplPackageName());
            String daoPath = javaPath + Utils.packageToPath(param.getDaoPackageName());
            String entityPath = javaPath + Utils.packageToPath(param.getEntityPackageName());
            String mapperPath = resPath + "mapper/";

            String controllerFile = controllerPath + param.getClassName() + "Controller.java";
            String serviceFile = servicePath + param.getClassName() + "Service.java";
            String serviceImplFile = serviceImplPath + param.getClassName() + "ServiceImpl.java";
            String daoFile = daoPath + param.getClassName() + "Dao.java";
            String entityFile = entityPath + param.getClassName() + ".java";
            String mapperFile = mapperPath + param.getClassName() + "Mapper.xml";

            logger.info("Save code to path: {}", controllerFile);
            logger.info("Save code to path: {}", serviceFile);
            logger.info("Save code to path: {}", serviceImplFile);
            logger.info("Save code to path: {}", daoFile);
            logger.info("Save code to path: {}", entityFile);
            logger.info("Save code to path: {}", mapperFile);

            Utils.writeFile(controllerFile, controller);
            Utils.writeFile(serviceFile, service);
            Utils.writeFile(serviceImplFile, serviceImpl);
            Utils.writeFile(daoFile, dao);
            Utils.writeFile(entityFile, entity);
            Utils.writeFile(mapperFile, mapper);
        }

        String log4j2 = engine.render("log4j2.xml.ftl", new Object());
        String log4j2File = resPath + "log4j2.xml";
        Utils.writeFile(log4j2File, log4j2);

        String pom = engine.render("pom.xml.ftl", new Object());
        String pomFile = projectPath + "/pom.xml";
        Utils.writeFile(pomFile, pom);
    }

    private String generateMapperInsertProperties(List<TableColumn> columns) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < columns.size(); i++) {
            if (i != 0) {
                sb.append("            ");
            }
            sb.append(columns.get(i).getColumnName()).append(",\n");
        }
        return sb.toString().substring(0, sb.toString().length() - 2);
    }

    private String generateMapperInsertValues(List<TableColumn> columns) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < columns.size(); i++) {
            if (i != 0) {
                sb.append("            ");
            }
            sb.append("#{").append(columns.get(i).getPropertyName()).append("},\n");
        }
        return sb.toString().substring(0, sb.toString().length() - 2);
    }

}
