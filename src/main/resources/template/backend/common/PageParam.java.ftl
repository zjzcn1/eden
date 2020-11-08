package ${packageName}.common;

import lombok.Data;

import java.util.List;

@Data
public class PageParam {

    private int page = 0;
    private int size = 10;
    private List<QueryParam> params;

    private PageParam(int page, int size, List<QueryParam> params) {
        this.page = page;
        this.size = size;
        this.params = params;
    }

    public static PageParam of(int page, int size, List<QueryParam> params) {
        return new PageParam(page, size, params);
    }
}