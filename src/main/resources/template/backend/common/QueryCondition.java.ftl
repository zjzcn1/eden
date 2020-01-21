package ${packageName}.common;

import lombok.Data;

@Data
public class QueryCondition {

    private String column;
    private String op;
    private Object value;
}
