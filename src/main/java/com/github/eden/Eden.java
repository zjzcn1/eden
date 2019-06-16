package com.github.eden;

import ch.qos.logback.classic.LoggerContext;
import ch.qos.logback.classic.joran.JoranConfigurator;
import ch.qos.logback.core.joran.spi.JoranException;
import org.slf4j.LoggerFactory;

import java.io.File;

public class Eden {

    private static final String CONFIG_FILE = "conf/config.yaml";
    private static final String LOGBACK_XML_FILE = "conf/logback.xml";

    public static void main(String[] args) {
        String rootPath = Utils.getRootPath();

        initLogback(rootPath);

        Config config = Utils.loadYaml(rootPath + CONFIG_FILE, Config.class);
        CodeGenerator generator = new CodeGenerator(config);

        generator.generateCode();
    }

    private static void initLogback(String rootPath) {
        File file = new File(rootPath + LOGBACK_XML_FILE);
        if (!file.exists()) {
            System.err.println("Not find logback config, path= " + file);
            System.exit(-1);
            return;
        }
        LoggerContext ctx = (LoggerContext) LoggerFactory.getILoggerFactory();
        JoranConfigurator configurator = new JoranConfigurator();
        configurator.setContext(ctx);
        ctx.reset();
        try {
            configurator.doConfigure(file);
        } catch (JoranException e) {
            e.printStackTrace(System.err);
            System.exit(-1);
        }
    }
}
