package com.github.eden;


import lombok.AllArgsConstructor;
import lombok.Data;

import java.io.Serializable;

@Data
@AllArgsConstructor
public class TableColumn implements Serializable {
    private String columnName; // 列名
    private String typeName; // 类型
    private String propertyName; // 属性名
    private boolean isPrimaryKey; // 是否主键
    private String comment; // 注释

}
