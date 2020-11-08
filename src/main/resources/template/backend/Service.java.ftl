package ${packageName}.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import ${packageName}.entity.${table.className};
import ${packageName}.dao.${table.className}Dao;
import ${packageName}.common.QueryBuilder;
import ${packageName}.common.QueryParam;
import ${packageName}.common.Page;
import ${packageName}.common.Pageable;
import ${packageName}.common.PageParam;

import java.util.List;
import java.util.Map;

/**
 * Date  ${date}
 */
@Slf4j
@Service
public class ${table.className}Service {

    @Autowired
    protected ${table.className}Dao ${table.objectName}Dao;

    @Transactional
    public Long create${table.className}(${table.className} ${table.objectName}) {
        return ${table.objectName}Dao.insert(${table.objectName});
    }

    @Transactional
    public int update${table.className}(${table.className} ${table.objectName}) {
        return ${table.objectName}Dao.update(${table.objectName});
    }

    @Transactional
    public int delete${table.className}(Long id) {
        return ${table.objectName}Dao.delete(id);
    }

    public ${table.className} get${table.className}ById(Long id) {
        return ${table.objectName}Dao.getById(id);
    }

    public List<${table.className}> get${table.className}ListByIds(List<Long> ids) {
        return ${table.objectName}Dao.getListByIds(ids);
    }

    public int count${table.className}(Map<String, Object> params) {
        List<QueryParam> queryParams = QueryBuilder.create()
                .build();
        return ${table.objectName}Dao.count(queryParams);
    }

    public List<${table.className}> list${table.className}(Map<String, Object> params) {
        List<QueryParam> queryParams = QueryBuilder.create()
                .build();
        return ${table.objectName}Dao.list(queryParams);
    }

    public Page<${table.className}> page${table.className}(Pageable pageable) {
        List<QueryParam> queryParams = QueryBuilder.create()
                .build();
        return ${table.objectName}Dao.page(PageParam.of(pageable.getPage(), pageable.getSize(), queryParams));
    }

}
