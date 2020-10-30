package ${packageName}.common;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import org.springframework.beans.factory.annotation.Autowired;

public class BaseServiceImpl<T, M extends BaseDao<T>> implements BaseService<T> {

    @Autowired
    protected M dao;

    @Override
    public Long insert(T entity) {
        return dao.insert(entity);
    }

    @Override
    public int update(T entity) {
        return dao.update(entity);
    }

    @Override
    public int delete(Long id) {
        return dao.delete(id);
    }

    @Override
    public T getById(Long id) {
        return dao.getById(id);
    }

    @Override
    public List<T> getListByIds(List<Long> ids) {
        return dao.getListByIds(ids);
    }

    @Override
    public int count(Map<String, Object> params) {
        if (params == null) {
            params = new HashMap<>();
        }
        return dao.count(params);
    }

    @Override
    public List<T> list(Map<String, Object> params) {
        if (params == null) {
            params = new HashMap<>();
        }
        return dao.list(params);
    }

    @Override
    public Page<T> page(Pageable pageable) {
        return dao.page(pageable);
    }

}