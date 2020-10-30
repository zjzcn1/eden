package com.github.eden;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.util.Locale;

public class TemplateEngine {

    private Configuration configuration;

    public TemplateEngine() {
        configuration = new Configuration(Configuration.VERSION_2_3_28);
        try {
            String path = new File(TemplateEngine.class.getClassLoader().getResource("template").getFile()).getPath();
            if (path.contains("jar")){
                configuration.setClassForTemplateLoading(TemplateEngine.class, "/template");
            } else {
                configuration.setDirectoryForTemplateLoading(new File(path));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        configuration.setEncoding(Locale.CHINA, "utf-8");
    }

    public String render(String fileName, Object param) {
        try {
            Template template = configuration.getTemplate(fileName);
            StringWriter writer = new StringWriter();
            template.process(param, writer);
            writer.flush();
            return writer.toString();
        } catch (IOException | TemplateException e) {
            throw new RuntimeException(e);
        }
    }
}
