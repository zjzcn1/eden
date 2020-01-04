package com.github.eden;

import org.apache.commons.lang3.time.DateFormatUtils;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ParamBuilder {

    public static String buildControllerFileName(String packageName, TableInfo table) {
        String path = EdenUtils.packageToPath(packageName + ".controller");
        return path + table.getClassName() + "Controller.java";
    }

    public static String buildServiceFileName(String packageName, TableInfo table) {
        String path = EdenUtils.packageToPath(packageName + ".service");
        return path + table.getClassName() + "Service.java";
    }

    public static String buildEntityFileName(String packageName, TableInfo table) {
        String path = EdenUtils.packageToPath(packageName + ".entity");
        return path + table.getClassName() + ".java";
    }

    public static String buildDaoFileName(String packageName, TableInfo table) {
        String path = EdenUtils.packageToPath(packageName + ".dao");
        return path + table.getClassName() + "Dao.java";
    }

    public static String buildMapperFileName(String packageName, TableInfo table) {
        String path = "mapper/";
        return path + table.getClassName() + "Mapper.xml";
    }

    public static String buildViewFileName(String packageName, TableInfo table) {
        return "src/views/" + table.getClassName() + "/" + table.getClassName() + ".vue";
    }

    public static String buildCommonPath(String packageName) {
        return EdenUtils.packageToPath(packageName + ".common");
    }

    public static String buildConfigPath(String packageName) {
        return EdenUtils.packageToPath(packageName + ".config");
    }

    public static String buildBasePackagePath(String packageName) {
        return EdenUtils.packageToPath(packageName);
    }

    public static Map<String, Object> buildParam(String packageName, TableInfo table, List<TableColumn> columns) {
        Map<String, Object> param = new HashMap<>();
        param.put("date", DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
        param.put("tableName", table.getTableName());
        param.put("packageName", packageName);
        param.put("objectName", table.getObjectName());
        param.put("className", table.getClassName());
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
