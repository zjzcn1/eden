package com.github.eden;


import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class TableColumn {

    private String columnName; // 列名
    private String typeName; // 类型
    private boolean isPrimaryKey; // 是否主键
    private String comment; // 注释

    private String propertyName; // 字段名
}
