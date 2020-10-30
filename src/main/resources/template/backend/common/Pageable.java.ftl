package ${packageName}.common;

import lombok.Data;

import java.util.HashMap;
import java.util.Map;

@Data
public class Pageable {

    private int size = 10;
    private int page = 0;
    private Map<String, Object> params = new HashMap<>();

}