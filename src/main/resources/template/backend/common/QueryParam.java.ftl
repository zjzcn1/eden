package ${packageName}.common;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class QueryParam {

    private String field;
    private Object value;
    private String op;

}
