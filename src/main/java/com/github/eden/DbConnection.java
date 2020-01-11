package com.github.eden;

import lombok.extern.slf4j.Slf4j;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

@Slf4j
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
                tables.add(resultSet.getString(1));
            }
            statement.close();
            resultSet.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return tables;
    }

    /**
     * 获得某表的建表语句
     * @param tableName
     * @return
     * @throws Exception
     */
    public String getCommentByTableName(String tableName) {
        String comment = null;
        try {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SHOW CREATE TABLE " + tableName);
            if (resultSet != null && resultSet.next()) {
                String ddl = resultSet.getString(2);
                comment = parseTableComment(ddl);
            }
            statement.close();
            resultSet.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return comment;
    }

    public static String parseTableComment(String all) {
        String comment;
        int index = all.indexOf("COMMENT='");
        if (index < 0) {
            return "";
        }
        comment = all.substring(index + 9);
        comment = comment.substring(0, comment.length() - 1);
        return comment;

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
                String comment = resultSet.getString("COMMENT");

                TableColumn column = new TableColumn();
                column.setColumnName(name);
                column.setTypeName(type);
                column.setComment(comment);
                column.setIsPrimaryKey(isKey);
                columns.add(column);
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
