package com.github.eden;

public class Eden {

    public static void main(String[] args) {
        String rootPath = Utils.getRootPath();
        Config config = Utils.loadYaml(rootPath + "/conf/config.yaml", Config.class);
        CodeGenerator generator = new CodeGenerator(config);

        generator.generateCode();
    }

}
