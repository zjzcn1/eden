package com.github.eden;

import lombok.Data;

import java.io.Serializable;

@Data
public class Config implements Serializable {

    private String projectName;
    private String systemName;
    private String packageName;
    private String dbDriverClass;
    private String dbUrl;
    private String dbUsername;
    private String dbPassword;

}
