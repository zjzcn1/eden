package com.github.eden;


import lombok.AllArgsConstructor;
import lombok.Data;

import java.io.Serializable;

@Data
public class TableInfo implements Serializable {
    private String className; // 类名
    private String objectName; // 对象型
    private String tableName; // 表名
    private String tableComment; // 注释
}
