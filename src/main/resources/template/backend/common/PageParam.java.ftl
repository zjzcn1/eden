package ${packageName}.common;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class PageParam {

    private int page = 0;
    private int size = 10;
    private MapParam params = new MapParam();

    private List<QueryCondition> conditions = new ArrayList<>();

    public Object get(String key) {
        if (params == null) {
            return null;
        }
        return params.get(key);
    }

}
