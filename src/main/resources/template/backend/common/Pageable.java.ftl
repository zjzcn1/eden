package ${packageName}.common;

import lombok.Data;
import java.util.List;

@Data
public class Pageable {

    public static final Integer DEFAULT_PAGE_SIZE = 20;

    private int size = DEFAULT_PAGE_SIZE;
    private int page = 0;

    private List<QueryCondition> params;

}
