package com.github.eden;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;

import java.io.Serializable;
import java.util.List;

public class Param implements Serializable {

    private String date;
    private String objectName;
    private String tableName;
    private String className;
    private List<TableColumn> columns;
    private String packageName;
    private String controllerPackageName;
    private String servicePackageName;
    private String serviceImplPackageName;
    private String daoPackageName;
    private String entityPackageName;
    private String entityProperties;
    private String tableColumnNames;
    private String tableColumnValues;
    private String updateProperties;
    private String primaryKey;
    private String primaryKeyProperty;

    public Param(String packageName, String tableName, List<TableColumn> columns) {
        this.packageName = packageName;
        this.tableName = tableName;
        this.columns = columns;
        this.date = DateUtil.today();
        this.objectName = StrUtil.toCamelCase(tableName);
        this.className = StrUtil.upperFirst(objectName);
        this.controllerPackageName = this.packageName + ".controller";
        this.servicePackageName = this.packageName + ".service";
        this.serviceImplPackageName = this.packageName + ".service.impl";
        this.daoPackageName = this.packageName + ".dao";
        this.entityPackageName = this.packageName + ".entity";
        this.entityProperties = generateEntityProperties(columns);
        this.tableColumnNames = generateTableColumns(columns);
        this.tableColumnValues = generateTableValues(columns);
        this.updateProperties = generateUpdateProperties(columns);
        TableColumn primaryKeyColumn = getPrimaryKeyColumn(columns);
        if (primaryKeyColumn == null) {
            this.primaryKey = "id";
            this.primaryKeyProperty = "#{id}";
        } else {
            this.primaryKey = primaryKeyColumn.getColumnName();
            this.primaryKeyProperty = "#{" + primaryKeyColumn.getPropertyName() + "}";
        }
    }

    private TableColumn getPrimaryKeyColumn(List<TableColumn> columns) {
        for (TableColumn column : columns) {
            if (column.isPrimaryKey()) {
                return column;
            }
        }
        return null;
    }

    private String generateEntityProperties(List<TableColumn> columns) {
        StringBuilder sb = new StringBuilder();
        for (TableColumn column : columns) {
            sb.append("    private ").append(column.getTypeName()).append(" ").append(column.getPropertyName()).append(";\n");
        }
        return sb.toString();
    }

    private String generateTableColumns(List<TableColumn> columns) {
        StringBuilder sb = new StringBuilder();
        for (TableColumn column : columns) {
            sb.append(column.getColumnName()).append(", ");
        }
        return sb.toString().substring(0, sb.toString().length() - 2);
    }

    public static String generateTableValues(List<TableColumn> columns) {
        StringBuilder sb = new StringBuilder();
        for (TableColumn column : columns) {
            sb.append("#{").append(column.getPropertyName()).append("}, ");
        }
        return sb.toString().substring(0, sb.toString().length() - 2);
    }

    public static String generateUpdateProperties(List<TableColumn> columns) {
        StringBuilder sb = new StringBuilder();
        for (TableColumn column : columns) {
            sb.append(column.getColumnName()).append(" = #{").append(column.getPropertyName()).append("}, ");
        }
        return sb.toString().substring(0, sb.toString().length() - 2);
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getObjectName() {
        return objectName;
    }

    public void setObjectName(String objectName) {
        this.objectName = objectName;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public List<TableColumn> getColumns() {
        return columns;
    }

    public void setColumns(List<TableColumn> columns) {
        this.columns = columns;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public String getControllerPackageName() {
        return controllerPackageName;
    }

    public void setControllerPackageName(String controllerPackageName) {
        this.controllerPackageName = controllerPackageName;
    }

    public String getServicePackageName() {
        return servicePackageName;
    }

    public void setServicePackageName(String servicePackageName) {
        this.servicePackageName = servicePackageName;
    }

    public String getServiceImplPackageName() {
        return serviceImplPackageName;
    }

    public void setServiceImplPackageName(String serviceImplPackageName) {
        this.serviceImplPackageName = serviceImplPackageName;
    }

    public String getDaoPackageName() {
        return daoPackageName;
    }

    public void setDaoPackageName(String daoPackageName) {
        this.daoPackageName = daoPackageName;
    }

    public String getEntityPackageName() {
        return entityPackageName;
    }

    public void setEntityPackageName(String entityPackageName) {
        this.entityPackageName = entityPackageName;
    }

    public String getEntityProperties() {
        return entityProperties;
    }

    public void setEntityProperties(String entityProperties) {
        this.entityProperties = entityProperties;
    }

    public String getTableColumnNames() {
        return tableColumnNames;
    }

    public void setTableColumnNames(String tableColumnNames) {
        this.tableColumnNames = tableColumnNames;
    }

    public String getTableColumnValues() {
        return tableColumnValues;
    }

    public void setTableColumnValues(String tableColumnValues) {
        this.tableColumnValues = tableColumnValues;
    }

    public String getUpdateProperties() {
        return updateProperties;
    }

    public void setUpdateProperties(String updateProperties) {
        this.updateProperties = updateProperties;
    }

    public String getPrimaryKey() {
        return primaryKey;
    }

    public void setPrimaryKey(String primaryKey) {
        this.primaryKey = primaryKey;
    }

    public String getPrimaryKeyProperty() {
        return primaryKeyProperty;
    }

    public void setPrimaryKeyProperty(String primaryKeyProperty) {
        this.primaryKeyProperty = primaryKeyProperty;
    }
}
