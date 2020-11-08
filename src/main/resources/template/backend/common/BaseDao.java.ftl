package ${packageName}.common;

import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface BaseDao<T> {

    Long insert(T entity);

    int update(T entity);

    int delete(@Param("id") Long id);

    T getById(@Param("id") Long id);

    List<T> getListByIds(@Param("ids") List<Long> ids);

    int count(@Param("params") List<QueryParam> params);

    List<T> list(@Param("params") List<QueryParam> params);

    Page<T> page(PageParam param);

}