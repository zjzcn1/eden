package com.github.eden;

import ch.qos.logback.classic.LoggerContext;
import ch.qos.logback.classic.joran.JoranConfigurator;
import ch.qos.logback.core.joran.spi.JoranException;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.StrUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.yaml.snakeyaml.Yaml;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLDecoder;

public class Utils {

    private static final Logger log = LoggerFactory.getLogger(Utils.class);

    public static String getRootPath() {
        URL url = Utils.class.getProtectionDomain().getCodeSource().getLocation();
        String rootPath;
        try {
            rootPath = URLDecoder.decode(url.getPath(), "utf-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
        if (rootPath.endsWith(".jar")) {
            rootPath = rootPath.substring(0, rootPath.lastIndexOf("/lib/") + 1);
        } else {
            rootPath = rootPath.substring(0, rootPath.lastIndexOf("/target/classes/") + 1);
        }
        return rootPath;
    }

    public static <T> T loadYaml(String yamlFile, Class<T> clazz) {
        try {
            Yaml yaml = new Yaml();
            T config = yaml.loadAs(new FileInputStream(yamlFile), clazz);
            log.info("Loaded yaml config from path={}. {}", yamlFile, yaml.dump(config));
            return config;
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    public static void setLogbackFile(String logbackFile) {
        File file = new File(logbackFile);
        if (!file.exists()) {
            System.err.println("Not find logback.xml, file: " + file);
            System.exit(-1);
            return;
        }
        LoggerContext ctx = (LoggerContext) LoggerFactory.getILoggerFactory();
        JoranConfigurator configurator = new JoranConfigurator();
        configurator.setContext(ctx);
        ctx.reset();
        try {
            configurator.doConfigure(file);
            log.info("Loaded logback.xml success, file: {}.", file);
        } catch (JoranException e) {
            e.printStackTrace(System.err);
            System.exit(-1);
        }
    }

    public static String readFile(String fileName) {
        return FileUtil.readString(fileName, "utf-8");
    }

    public static void writeFile(String fileName, String content) {
        FileUtil.writeString(content, fileName, "utf-8");
    }

    public static String packageToPath(String packageName) {
        if (StrUtil.isBlank(packageName)) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        String[] packages = packageName.split("\\.");
        for (String str : packages) {
            sb.append(str).append(File.separator);
        }
        return sb.toString();
    }

}
