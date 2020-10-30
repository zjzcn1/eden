package ${packageName}.common;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;


public interface BaseDao<T> {

    Long insert(T entity);

    int update(T entity);

    int delete(@Param("id") Long id);

    T getById(@Param("id") Long id);

    List<T> getListByIds(@Param("ids") List<Long> ids);

    int count(@Param("params") Map<String, Object> params);

    List<T> list(@Param("params") Map<String, Object> params);

    Page<T> page(Pageable pageable);

}