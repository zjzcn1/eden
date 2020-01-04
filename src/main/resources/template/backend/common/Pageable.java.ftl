package ${packageName}.common;

import lombok.Data;
import java.util.Map;

@Data
public class Pageable {

    public static final Integer DEFAULT_PAGE_SIZE = 20;

    private int size = DEFAULT_PAGE_SIZE;
    private int current = 0;

    private Map<String, Object> params;

}
