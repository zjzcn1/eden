package com.github.eden;

import java.io.IOException;

public class Eden {

    private static final String CONFIG_FILE = "conf/config.yaml";
    private static final String LOGBACK_XML_FILE = "conf/logback.xml";

    public static void main(String[] args) throws IOException {
        String rootPath = Utils.getRootPath();

        Utils.setLogbackFile(rootPath + LOGBACK_XML_FILE);

        Config config = Utils.loadYaml(rootPath + CONFIG_FILE, Config.class);
        CodeGenerator generator = new CodeGenerator(config);

        generator.generateCode();
    }

}
