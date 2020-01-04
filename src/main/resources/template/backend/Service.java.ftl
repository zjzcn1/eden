package ${packageName}.service;

import java.util.List;
import ${packageName}.common.Page;
import ${packageName}.common.Pageable;
import ${packageName}.entity.${className};
import ${packageName}.dao.${className}Dao;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Date  ${date}
 */
@Slf4j
@Service
public class ${className}Service {

    @Autowired
    private ${className}Dao ${objectName}Dao;

    public ${className} get${className}(Long id) {
        return ${objectName}Dao.getById(id);
    }

    public List<${className}> findAll${className}() {
        return ${objectName}Dao.findAll();
    }

    public Page<${className}> findByPageable(Pageable pageable) {
        return ${objectName}Dao.findByPageable(pageable);
    }

    public Long insert${className}(${className} ${objectName}) {
        log.info("Insert ${objectName}={}", ${objectName});
        return ${objectName}Dao.insert(${objectName});
    }

    public int update${className}(${className} ${objectName}) {
        log.info("Update ${objectName}={}", ${objectName});
        return ${objectName}Dao.update(${objectName});
    }

    public int delete${className}(Long id) {
        log.info("Delete ${objectName}, id={}", id);
        return ${objectName}Dao.delete(id);
    }
}
