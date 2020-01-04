package com.github.eden;


import lombok.Data;

@Data
public class TableInfo {

    private String className; // 类名
    private String objectName; // 对象型
    private String tableName; // 表名
    private String tableComment; // 注释
}
