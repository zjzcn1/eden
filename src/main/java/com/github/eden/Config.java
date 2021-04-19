package com.github.eden;

import lombok.Data;

import java.util.List;

@Data
public class Config {

    private String projectName;
    private String systemName;
    private String packageName;
    private String dbDriverClass;
    private String dbUrl;
    private String dbUsername;
    private String dbPassword;

    private List<String> unusedTables;
    private String createTimeColumn;
    private String updateTimeColumn;
    private String deletedColumn;
    private String enabledColumn;

}
