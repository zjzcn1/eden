package ${packageName}.service;

import java.util.List;
import ${packageName}.common.Page;
import ${packageName}.common.Pageable;
import ${packageName}.entity.${table.className};
import ${packageName}.dao.${table.className}Dao;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Date  ${date}
 */
@Slf4j
@Service
public class ${table.className}Service {

    @Autowired
    private ${table.className}Dao ${table.objectName}Dao;

    public ${table.className} get${table.className}(Long id) {
        return ${table.objectName}Dao.getById(id);
    }

    public List<${table.className}> findAll${table.className}() {
        return ${table.objectName}Dao.findAll();
    }

    public Page<${table.className}> findByPageable(Pageable pageable) {
        return ${table.objectName}Dao.findByPageable(pageable);
    }

    public Long insert${table.className}(${table.className} ${table.objectName}) {
        log.info("Insert ${table.objectName}={}", ${table.objectName});
        return ${table.objectName}Dao.insert(${table.objectName});
    }

    public int update${table.className}(${table.className} ${table.objectName}) {
        log.info("Update ${table.objectName}={}", ${table.objectName});
        return ${table.objectName}Dao.update(${table.objectName});
    }

    public int delete${table.className}(Long id) {
        log.info("Delete ${table.objectName}, id={}", id);
        return ${table.objectName}Dao.delete(id);
    }
}
