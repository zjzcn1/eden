package ${packageName}.common;

import lombok.Data;
import java.util.List;

@Data
public class Page<T> {

    private int size;
    private int page;
    private long total;
    private List<T> list;

    private Page(int page, int size, long total, List<T> list) {
        this.page = page;
        this.size = size;
        this.total = total;
        this.list = list;
    }

    public static <T> Page<T> of(PageParam pageParam, long total, List<T> list) {
        return new Page<>(pageParam.getPage(), pageParam.getSize(), total, list);
    }

    public static <T> Page<T> of(int page, int size, long total, List<T> list) {
        return new Page<>(page, size, total, list);
    }
}

