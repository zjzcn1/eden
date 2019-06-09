<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
    <settings>
        <!-- 缓存的全局开关 -->
        <setting name="cacheEnabled" value="false"/>
        <!-- 开启自动驼峰命名规则 -->
        <setting name="mapUnderscoreToCamelCase" value="true"/>
    </settings>

    <plugins>
        <plugin interceptor="admin.common.PagePlugin">
        </plugin>
    </plugins>
</configuration>