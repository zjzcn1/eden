package ${packageName}.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import ${packageName}.entity.${table.className};
import ${packageName}.dao.${table.className}Dao;
import ${packageName}.common.QueryBuilder;
import ${packageName}.common.QueryCondition;
import ${packageName}.common.Page;
import ${packageName}.common.PageParam;
import ${packageName}.common.MapParam;

import java.util.List;

/**
 * Date  ${date}
 */
@Slf4j
@Service
public class ${table.className}Service {

    @Autowired
    private ${table.className}Dao ${table.objectName}Dao;

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

    public int count${table.className}(MapParam params) {
        List<QueryCondition> conditions = QueryBuilder.create()
                .build();
        return ${table.objectName}Dao.count(conditions);
    }

    public List<${table.className}> list${table.className}(MapParam params) {
        List<QueryCondition> conditions = QueryBuilder.create()
                .build();
        return ${table.objectName}Dao.list(conditions);
    }

    public Page<${table.className}> page${table.className}(PageParam params) {
        List<QueryCondition> conditions = QueryBuilder.create()
                .build();
        params.setConditions(conditions);
        return ${table.objectName}Dao.page(params);
    }

}
