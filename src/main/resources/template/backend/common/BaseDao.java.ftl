package ${packageName}.common;

import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface BaseDao<T> {

    void insert(T entity);

    int update(T entity);

    int updateSelective(T entity);

    int delete(@Param("id") Long id);

    T getById(@Param("id") Long id);

    List<T> getListByIds(@Param("ids") List<Long> ids);

    int count(@Param("conditions") List<QueryCondition> conditions);

    List<T> list(@Param("conditions") List<QueryCondition> conditions);

    Page<T> page(PageParam param);

}