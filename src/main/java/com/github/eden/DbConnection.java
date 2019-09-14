package com.github.eden;

import cn.hutool.core.util.StrUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DbConnection {

    private Connection connection;

    public DbConnection(Config config) {
        try {
            Class.forName(config.getDbDriverClass());
            connection = DriverManager.getConnection(config.getDbUrl(), config.getDbUsername(), config.getDbPassword());
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<String> getTables() {
        List<String> tables = new ArrayList<>();
        try {
            Statement statement = connection.createStatement();
            String sql = "show tables";
            ResultSet resultSet = statement.executeQuery(sql);
            while (resultSet.next()) {
                System.out.println(resultSet.getString(1));
                tables.add(resultSet.getString(1));
            }
            statement.close();
            resultSet.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return tables;
    }

    public List<TableColumn> getColumns(String tableName) {
        List<TableColumn> columns = new ArrayList<>();
        try {
            String sql = "show full fields from " + tableName;
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                String name = resultSet.getString("FIELD");
                String type = resultSet.getString("TYPE");
                if (type.indexOf("(") > 0) {
                    type = type.substring(0, type.indexOf("("));
                }
                type = parseTypeFormSqlType(type);
                boolean isKey = false;
                if ("PRI".equalsIgnoreCase(resultSet.getString("KEY"))) {
                    isKey = true;
                }
                String propertyName = StrUtil.toCamelCase(name);
                String comment = resultSet.getString("COMMENT");
                columns.add(new TableColumn(name, type, propertyName, isKey, comment));
            }
            statement.close();
            resultSet.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return columns;
    }

    private String parseTypeFormSqlType(String type) {
        type = type.toUpperCase();
        if (type.contains("CHAR")) {
            return "String";
        } else if (type.contains("BIGINT")) {
            return "Long";
        } else if (type.contains("INT")) {
            return "Integer";
        } else if (type.contains("DATE")) {
            return "Date";
        } else if (type.contains("TEXT")) {
            return "String";
        } else if (type.contains("TIMESTAMP")) {
            return "Date";
        } else if (type.contains("BIT")) {
            return "Boolean";
        } else if (type.contains("DECIMAL")) {
            return "BigDecimal";
        } else if (type.contains("BLOB")) {
            return "byte[]";
        } else if (type.contains("DOUBLE")) {
            return "Double";
        } else {
            return "Object";
        }
    }
}
