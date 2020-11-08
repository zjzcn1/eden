package ${packageName}.common;

import lombok.Data;

import java.util.List;

@Data
public class Pageable {

    private int page = 0;
    private int size = 10;
    private List<QueryParam> params;

    private Pageable(int page, int size, List<QueryParam> params) {
        this.page = page;
        this.size = size;
        this.params = params;
    }

    public static Pageable of(int page, int size, List<QueryParam> params) {
        return new Pageable(page, size, params);
    }
}