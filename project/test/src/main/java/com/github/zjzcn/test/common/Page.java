package com.github.zjzcn.test.common;

import lombok.Data;
import java.util.List;

@Data
public class Page<T> {

    private int size;
    private int current;
    private long total;
    private List<T> list;

    private Page(int current, int size, long total, List<T> list) {
        this.current = current;
        this.size = size;
        this.total = total;
        this.list = list;
    }

    public static <T> Page<T> of(Pageable pageable, long total, List<T> list) {
        return new Page<>(pageable.getCurrent(), pageable.getSize(), total, list);
    }

    public static <T> Page<T> of(int current, int size, long total, List<T> list) {
        return new Page<>(current, size, total, list);
    }
}
