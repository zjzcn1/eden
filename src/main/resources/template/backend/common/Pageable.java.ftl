package ${packageName}.common;

import lombok.Data;

import java.util.Map;
import java.util.HashMap;

@Data
public class Pageable {

    private int page = 0;
    private int size = 10;
    private Map<String, Object> params = new HashMap<>();

}