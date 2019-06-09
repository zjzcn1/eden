
import lombok.Data;

import java.util.List;

@Data
public class Page<T> {

    public static final Integer DEFAULT_PAGE_SIZE = 20;

    private Integer size;
    private Integer current;
    private Integer total;
    private List<T> items;

    private Page(Integer current, Integer size, Integer total, List<T> items) {
        this.current = current;
        this.size = size;
        this.total = total;
        this.items = items;
    }

    public static <T> Page<T> of(Pageable param, Integer total, List<T> items) {
        return new Page<>(param.getCurrent(), param.getSize(), total, items);
    }

    public static <T> Page<T> of(Integer current, Integer total, List<T> items) {
        return new Page<>(current, DEFAULT_PAGE_SIZE, total, items);
    }

    public static <T> Page<T> of(Integer current, Integer size, Integer total, List<T> items) {
        return new Page<>(current, size, total, items);
    }
}
