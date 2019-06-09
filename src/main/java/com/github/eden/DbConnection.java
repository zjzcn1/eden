package com.github.eden;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class DbConnection {

    public DbConnection(String dbUrl, String dbUsername, String dbPassword) {

    }

    public List<String> getTables() {
        List<String> tables = new ArrayList<>();
        tables.add("user");
        tables.add("role");
        tables.add("user_role");
        return tables;
    }

    public List<TableColumn> getColumns(String tableName) {
        List<TableColumn> columns = new ArrayList<>();
        columns.add(new TableColumn("id", "Long", true));
        columns.add(new TableColumn("name", "String", true));
        return columns;
    }

    private String parseTypeFormSqlType(int sqlType) {
        StringBuilder sb = new StringBuilder();
        switch (sqlType) {
            case Types.BIT:
            case Types.BOOLEAN:
                sb.append("Boolean");
                break;
            case Types.TINYINT:
                sb.append("Byte");
                break;
            case Types.SMALLINT:
                sb.append("Short");
                break;
            case Types.INTEGER:
                sb.append("Integer");
                break;
            case Types.BIGINT:
                sb.append("Long");
                break;
            case Types.REAL:
                sb.append("Float");
                break;
            case Types.FLOAT:
            case Types.DOUBLE:
                sb.append("Double");
                break;
            case Types.DECIMAL:
            case Types.NUMERIC:
                sb.append("BigDecimal");
                break;
            case Types.VARCHAR:
            case Types.CHAR:
            case Types.NCHAR:
            case Types.NVARCHAR:
            case Types.LONGVARCHAR:
            case Types.LONGNVARCHAR:
                sb.append("String");
                break;
            case Types.DATE:
                sb.append("Date");
                break;
            case Types.TIME:
                sb.append("Time");
                break;
            case Types.TIMESTAMP:
                sb.append("Timestamp");
                break;
            case Types.NCLOB:
            case Types.CLOB:
            case Types.BLOB:
            case Types.BINARY:
            case Types.VARBINARY:
            case Types.LONGVARBINARY:
                sb.append("byte[]");
                break;
            case Types.NULL:
            case Types.OTHER:
            case Types.JAVA_OBJECT:
                sb.append("Object");
                break;
            default:
                sb.append("Object");

        }
        return sb.toString();
    }
}
