<?xml version="1.0" encoding="UTF-8"?>
<Configuration status="OFF">
    <appenders>
        <Console name="Console" target="SYSTEM_OUT">
            <PatternLayout pattern="%d{yyyy-MM-dd HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n"/>
        </Console>
    </appenders>
    <loggers>
        <root level="debug">
            <appender-ref ref="Console"/>
        </root>
    </loggers>
</Configuration>