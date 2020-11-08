package com.github.eden;

import org.apache.commons.lang3.time.DateFormatUtils;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ParamBuilder {

    public static String buildControllerFileName(String packageName, String className) {
        String path = Utils.packageToPath(packageName + ".controller");
        return path + className + "Controller.java";
    }

    public static String buildServiceFileName(String packageName, String className) {
        String path = Utils.packageToPath(packageName + ".service");
        return path + className + "Service.java";
    }

    public static String buildServiceImplFileName(String packageName, String className) {
        String path = Utils.packageToPath(packageName + ".service.impl");
        return path + className + "ServiceImpl.java";
    }

    public static String buildEntityFileName(String packageName, String className) {
        String path = Utils.packageToPath(packageName + ".entity");
        return path + className + ".java";
    }

    public static String buildDaoFileName(String packageName, String className) {
        String path = Utils.packageToPath(packageName + ".dao");
        return path + className + "Dao.java";
    }

    public static String buildMapperFileName(String className) {
        String path = "mapper/";
        return path + className + "Mapper.xml";
    }

    public static String buildViewFileName(String className) {
        return "src/views/" + className + ".vue";
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

    public static Map<String, Object> buildParam(String packageName, TableInfo table, List<TableColumn> columns, Config config) {
        Map<String, Object> param = new HashMap<>();
        param.put("date", DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
        param.put("packageName", packageName);

        param.put("table", table);
        param.put("columns", columns);

        param.put("entityProperties", generateEntityProperties(columns));
        param.put("baseColumnNames", generateBaseColumnNames(columns));
        param.put("insertColumnNames", generateInsertColumnNames(columns));
        param.put("insertColumnValues", generateInsertColumnValues(columns));
        param.put("updateColumnValues", generateUpdateColumnValues(columns));

        // find special column
        TableColumn primaryKeyColumn = getPrimaryKeyColumn(columns);
        if (primaryKeyColumn == null) {
            throw new RuntimeException("Database table='" + table.getTableName() + "' not have primary key.");
        }
        param.put("primaryKeyColumn", primaryKeyColumn.getColumnName());
        param.put("primaryKeyProperty", "#{" + primaryKeyColumn.getPropertyName() + "}");

        for (TableColumn column : columns) {
            if (column.getColumnName().equals(config.getDeletedColumn())) {
                param.put("deletedColumn", column.getColumnName());
            }
        }
        return param;
    }

    private static TableColumn getPrimaryKeyColumn(List<TableColumn> columns) {
        for (TableColumn column : columns) {
            if (column.getIsPrimaryKey()) {
                return column;
            }
        }
        return null;
    }

    private static String generateEntityProperties(List<TableColumn> columns) {
        StringBuilder sb = new StringBuilder();
        for (TableColumn column : columns) {
            if (column.getIsEnabledColumn()) {
                sb.append("    // ").append(column.getComment()).append("\n");
                sb.append("    private ").append("Boolean ").append(column.getPropertyName()).append(";\n");
            } else if (!column.getIsDeletedColumn()) {
                sb.append("    // ").append(column.getComment()).append("\n");
                sb.append("    private ").append(column.getTypeName()).append(" ").append(column.getPropertyName()).append(";\n");
            }
        }
        return sb.toString();
    }

    private static String generateBaseColumnNames(List<TableColumn> columns) {
        StringBuilder sb = new StringBuilder();
        for (TableColumn column : columns) {
            if (!column.getIsDeletedColumn()) {
                sb.append(column.getColumnName()).append(", ");
            }
        }
        return sb.toString().substring(0, sb.toString().length() - 2);
    }

    private static String generateInsertColumnNames(List<TableColumn> columns) {
        StringBuilder sb = new StringBuilder();
        for (TableColumn column : columns) {
            if (!column.getIsPrimaryKey()
                    && !column.getIsCreateTimeColumn()
                    && !column.getIsUpdateTimeColumn()
                    && !column.getIsDeletedColumn()
                    && !column.getIsEnabledColumn()) {
                sb.append(column.getColumnName()).append(", ");
            }
        }
        return sb.toString().substring(0, sb.toString().length() - 2);
    }

    private static String generateInsertColumnValues(List<TableColumn> columns) {
        StringBuilder sb = new StringBuilder();
        for (TableColumn column : columns) {
            if (!column.getIsPrimaryKey()
                    && !column.getIsCreateTimeColumn()
                    && !column.getIsUpdateTimeColumn()
                    && !column.getIsDeletedColumn()
                    && !column.getIsEnabledColumn()) {
                sb.append("#{").append(column.getPropertyName()).append("}, ");
            }
        }
        if (sb.length() > 2) {
            return sb.substring(0, sb.length() - 2);
        } else {
            return sb.toString();
        }
    }

    private static String generateUpdateColumnValues(List<TableColumn> columns) {
        StringBuilder sb = new StringBuilder();
        for (TableColumn column : columns) {
            if (!column.getIsPrimaryKey()
                    && !column.getIsCreateTimeColumn()
                    && !column.getIsUpdateTimeColumn()
                    && !column.getIsDeletedColumn()) {
                sb.append(column.getColumnName()).append(" = #{").append(column.getPropertyName()).append("},")
                        .append("\n            ");
            }
        }
        return sb.toString().substring(0, sb.toString().lastIndexOf(","));
    }

}
