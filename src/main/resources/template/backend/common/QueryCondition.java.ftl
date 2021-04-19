package ${packageName}.common;

import lombok.Data;

@Data
public class QueryCondition {

    public QueryCondition(String field, Object value, String op) {
        this.field = field;
        this.value = value;
        this.op = op;
    }

    private String field;
    private Object value;
    private String op;

}

