spring.application.name=springboot-demo
application.main=com.github.springboot.demo.Application
#服务器端口
server.port=8081
server.session-timeout=60
server.tomcat.max-threads=800
server.tomcat.connector.max-http-header-size=102400000
logging.level.root=DEBUG

#上传文件最大容量
spring.http.multipart.maxFileSize=1000Mb
spring.http.multipart.maxRequestSize=10000Mb

spring.datasource.url=jdbc:mysql://localhost:3306/my_db?autoReconnect=true&useUnicode=true&characterEncoding=utf-8&useSSL=false
spring.datasource.username=root
spring.datasource.password=njutzjz126
spring.datasource.driverClassName=com.mysql.jdbc.Driver

spring.datasource.type=com.zaxxer.hikari.HikariDataSource
spring.datasource.min-idle=5
spring.datasource.max-active=100
spring.datasource.validation-query=select 1 from dual
spring.datasource.connection-timeout=60000
spring.datasource.max-left-time=60000
spring.datasource.validation-time-out=3000
spring.datasource.idle-time-out=60000
spring.datasource.connection-init-sql= set names utf8mb4

mybatis.configuration.map-underscore-to-camel-case=true
mybatis.mapper-locations=classpath*:mapper/*Mapper.xml
