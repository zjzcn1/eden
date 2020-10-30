package ${packageName}.common;

import java.util.List;
import java.util.Map;


public interface BaseService<T> {

    Long insert(T entity);

    int update(T entity);

    int delete(Long id);

    T getById(Long id);

    List<T> getListByIds(List<Long> ids);

    int count(Map<String, Object> params);

    List<T> list(Map<String, Object> params);

    Page<T> page(Pageable pageable);

}