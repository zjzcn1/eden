package com.github.eden;

import ch.qos.logback.classic.LoggerContext;
import ch.qos.logback.classic.joran.JoranConfigurator;
import ch.qos.logback.core.joran.spi.JoranException;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.yaml.snakeyaml.Yaml;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.JarURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.util.Enumeration;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;

public class EdenUtils {

    private static final Logger log = LoggerFactory.getLogger(EdenUtils.class);

    public static String getRootPath() {
        URL url = EdenUtils.class.getProtectionDomain().getCodeSource().getLocation();
        String path;
        try {
            path = URLDecoder.decode(url.getPath(), "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
        if (path.endsWith(".jar")) {
            path = path.substring(0, path.lastIndexOf("/lib/") + 1);
        } else {
            path = path.substring(0, path.lastIndexOf("/target/classes/") + 1);
        }
        return path;
    }

    public static void copyResources(String resourcePath, String toPath) throws IOException {
        URL url = EdenUtils.class.getProtectionDomain().getCodeSource().getLocation();
        String path;
        try {
            path = URLDecoder.decode(url.getPath(), "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
        if (path.endsWith(".jar")) {
            JarFile jarFile = new JarFile(path);
            Enumeration<JarEntry> entries = jarFile.entries();
            while (entries.hasMoreElements()) {
                JarEntry jarEntry = entries.nextElement();
                String innerPath = jarEntry.getName();
                if(innerPath.startsWith(resourcePath) && !jarEntry.isDirectory()){
                    InputStream inputStream = EdenUtils.class.getClassLoader().getResourceAsStream(innerPath);
                    if (inputStream != null) {
                        byte[] bytes = IOUtils.toByteArray(inputStream);
                        File file = new File(toPath + File.separator + innerPath);
                        if (!file.getParentFile().exists()) {
                            file.getParentFile().mkdirs();
                        }
                        FileUtils.writeByteArrayToFile(file, bytes);
                    }
                }
            }
        } else {
            String realPath = EdenUtils.class.getClassLoader().getResource(resourcePath).getPath();
            FileUtils.copyDirectory(new File(realPath), new File(toPath + File.separator + resourcePath));
        }
    }

    public static <T> T loadYaml(String yamlFile, Class<T> clazz) {
        try {
            Yaml yaml = new Yaml();
            T config = yaml.loadAs(new FileInputStream(yamlFile), clazz);
            String yamlStr = FileUtils.readFileToString(new File(yamlFile), "utf-8");
            log.info("Loaded yaml config from path={}. \n" +
                    "----------------------------------\n" +
                    "{}\n" +
                    "----------------------------------", yamlFile, yamlStr);
            return config;
        } catch (Exception e) {
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

    /**
     * 转换为下划线
     *
     * @param camelCaseName
     * @return
     */
    public static String toUnderline(String camelCaseName) {
        StringBuilder result = new StringBuilder();
        if (camelCaseName != null && camelCaseName.length() > 0) {
            result.append(camelCaseName.substring(0, 1).toLowerCase());
            for (int i = 1; i < camelCaseName.length(); i++) {
                char ch = camelCaseName.charAt(i);
                if (Character.isUpperCase(ch)) {
                    result.append("_");
                    result.append(Character.toLowerCase(ch));
                } else {
                    result.append(ch);
                }
            }
        }
        return result.toString();
    }

    /**
     * 转换为驼峰
     *
     * @param underlineName
     * @return
     */
    public static String toCamelCase(String underlineName) {
        StringBuilder result = new StringBuilder();
        if (underlineName != null && underlineName.length() > 0) {
            boolean flag = false;
            for (int i = 0; i < underlineName.length(); i++) {
                char ch = underlineName.charAt(i);
                if ("_".charAt(0) == ch) {
                    flag = true;
                } else {
                    if (flag) {
                        result.append(Character.toUpperCase(ch));
                        flag = false;
                    } else {
                        result.append(ch);
                    }
                }
            }
        }
        return result.toString();
    }

    public static String toBigCamelCase(String underlineName) {
        if (StringUtils.isBlank(underlineName)) {
            return underlineName;
        }
        String camelCase = toCamelCase(underlineName);
        return camelCase.substring(0, 1).toUpperCase() + camelCase.substring(1);
    }

    public static String packageToPath(String packageName) {
        if (StringUtils.isBlank(packageName)) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        String[] packages = packageName.split("\\.");
        for (String str : packages) {
            sb.append(str).append(File.separator);
        }
        return sb.toString();
    }

    public static void main(String[] args) throws IOException {
        JarFile localJarFile = new JarFile(new File("/Users/zjz/work/java/eden/target/eden-1.0.0/lib/eden-1.0.0.jar"));
        Enumeration<JarEntry> entries = localJarFile.entries();
        while (entries.hasMoreElements()) {
            JarEntry jarEntry = entries.nextElement();
            System.out.println(jarEntry.getName());
            String innerPath = jarEntry.getName();
            if(innerPath.startsWith("webui/") && !jarEntry.isDirectory()){
                InputStream inputStream = EdenUtils.class.getClassLoader().getResourceAsStream(innerPath);
                if (inputStream != null) {
                    byte[] bytes = IOUtils.toByteArray(inputStream);
                    File file = new File("/Users/zjz/work/java/eden/target/" + innerPath);
                    if (!file.getParentFile().exists()) {
                        file.getParentFile().mkdirs();
                    }
                    FileUtils.writeByteArrayToFile(file, bytes);
                }
            }
        }
    }

}
