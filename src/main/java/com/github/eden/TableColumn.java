package com.github.eden;


import lombok.Data;

@Data
public class TableColumn {

    private Boolean isPrimaryKey; // 是否主键
    private String columnName; // 列名
    private String typeName; // 类型
    private String comment; // 注释
    private String propertyName; // 字段名

    private Boolean isCreateTimeColumn;
    private Boolean isUpdateTimeColumn;
    private Boolean isDeletedColumn;
    private Boolean isEnabledColumn;
}
