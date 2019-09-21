package com.github.eden;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ParamBuilder {

    public static String buildControllerFileName(String packageName, String tableName) {
        String controllerPath = Utils.packageToPath(packageName + ".controller");
        return controllerPath + Utils.toClassName(tableName) + "Controller.java";
    }

    public static String buildServiceFileName(String packageName, String tableName) {
        String controllerPath = Utils.packageToPath(packageName + ".service");
        return controllerPath + Utils.toClassName(tableName) + "Service.java";
    }

    public static String buildServiceImplFileName(String packageName, String tableName) {
        String controllerPath = Utils.packageToPath(packageName + ".service.impl");
        return controllerPath + Utils.toClassName(tableName) + "ServiceImpl.java";
    }

    public static String buildEntityFileName(String packageName, String tableName) {
        String controllerPath = Utils.packageToPath(packageName + ".entity");
        return controllerPath + StrUtil.upperFirst(StrUtil.toCamelCase(tableName)) + ".java";
    }

    public static String buildDaoFileName(String packageName, String tableName) {
        String controllerPath = Utils.packageToPath(packageName + ".dao");
        return controllerPath + Utils.toClassName(tableName) + "Dao.java";
    }

    public static String buildMapperFileName(String packageName, String tableName) {
        String mapperPath = "mapper/";
        return mapperPath + StrUtil.upperFirst(StrUtil.toCamelCase(tableName)) + "Mapper.xml";
    }

    public static String buildViewFileName(String packageName, String tableName) {
        String name = StrUtil.upperFirst(StrUtil.toCamelCase(tableName));
        return "src/views/" + name + "/" + name + ".vue";
    }

    public static String buildCommonPath(String packageName) {
        return Utils.packageToPath(packageName + ".common");
    }

    public static String buildConfigPath(String packageName) {
        return Utils.packageToPath(packageName + ".config");
    }

    public static String buildBasePackagePath(String packageName) {
        return Utils.packageToPath(packageName);
    }

    public static Map<String, Object> buildParam(String packageName, String tableName, List<TableColumn> columns) {
        Map<String, Object> param = new HashMap<>();
        param.put("date", DateUtil.today());
        param.put("tableName", tableName);
        param.put("packageName", packageName);
        param.put("objectName", StrUtil.toCamelCase(tableName));
        param.put("className", StrUtil.upperFirst(StrUtil.toCamelCase(tableName)));
        param.put("entityProperties", generateEntityProperties(columns));
        param.put("tableColumnNames", generateTableColumnNames(columns));
        param.put("tableColumnValues", generateTableColumnValues(columns));
        param.put("updateProperties", generateUpdateProperties(columns));
        TableColumn primaryKeyColumn = getPrimaryKeyColumn(columns);
        if (primaryKeyColumn == null) {
            param.put("primaryKey", "id");
            param.put("primaryKeyValue", "#{id}");
        } else {
            param.put("primaryKey", primaryKeyColumn.getColumnName());
            param.put("primaryKeyValue", "#{" + primaryKeyColumn.getPropertyName() + "}");
        }
        return param;
    }

    private static TableColumn getPrimaryKeyColumn(List<TableColumn> columns) {
        for (TableColumn column : columns) {
            if (column.isPrimaryKey()) {
                return column;
            }
        }
        return null;
    }

    private static String generateEntityProperties(List<TableColumn> columns) {
        StringBuilder sb = new StringBuilder();
        for (TableColumn column : columns) {
            sb.append("    private ").append(column.getTypeName()).append(" ").append(column.getPropertyName()).append(";\n");
        }
        return sb.toString();
    }

    private static String generateTableColumnNames(List<TableColumn> columns) {
        StringBuilder sb = new StringBuilder();
        for (TableColumn column : columns) {
            sb.append(column.getColumnName()).append(", ");
        }
        return sb.toString().substring(0, sb.toString().length() - 2);
    }

    private static String generateTableColumnValues(List<TableColumn> columns) {
        StringBuilder sb = new StringBuilder();
        for (TableColumn column : columns) {
            sb.append("#{").append(column.getPropertyName()).append("}, ");
        }
        return sb.toString().substring(0, sb.toString().length() - 2);
    }

    private static String generateUpdateProperties(List<TableColumn> columns) {
        StringBuilder sb = new StringBuilder();
        for (TableColumn column : columns) {
            sb.append(column.getColumnName()).append(" = #{").append(column.getPropertyName()).append("}, ");
        }
        return sb.toString().substring(0, sb.toString().length() - 2);
    }

}
