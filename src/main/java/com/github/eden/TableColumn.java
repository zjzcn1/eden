package com.github.eden;


import cn.hutool.core.util.StrUtil;

import java.io.Serializable;

public class TableColumn implements Serializable {
    private String columnName; // 列名
    private String typeName; // 类型
    private String propertyName; // 属性名
    private boolean isPrimaryKey; // 是否主键

    public TableColumn(String columnName, String typeName, boolean isPrimaryKey) {
        this.columnName = columnName;
        this.typeName = typeName;
        this.propertyName = StrUtil.toCamelCase(columnName);
        this.isPrimaryKey = isPrimaryKey;
    }

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getPropertyName() {
        return propertyName;
    }

    public void setPropertyName(String propertyName) {
        this.propertyName = propertyName;
    }

    public boolean isPrimaryKey() {
        return isPrimaryKey;
    }

    public void setPrimaryKey(boolean primaryKey) {
        isPrimaryKey = primaryKey;
    }
}
