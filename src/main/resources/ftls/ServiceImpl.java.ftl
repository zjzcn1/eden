package ${packageName}.service.impl;

import ${packageName}.common.Page;
import ${packageName}.common.Pageable;
import ${packageName}.entity.${className};
import ${packageName}.service.${className}Service;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Date  2019-06-15
 */
@Slf4j
@Service
public class ${className}ServiceImpl implements ${className}Service {
    @Autowired
    private ${packageName}.dao.${className}Dao ${objectName}Dao;

    @Override
    public ${className} get${className}(Long id) {
        return ${objectName}Dao.getById(id);
    }

    @Override
    public Page<${className}> findByPageable(Pageable pageable) {
        return ${objectName}Dao.findByPageable(pageable);
    }

    @Override
    public Long insert${className}(${className} ${objectName}) {
        log.info("Insert ${objectName}={}", ${objectName});
        return ${objectName}Dao.insert(${objectName});
    }

    @Override
    public int update${className}(${className} ${objectName}) {
        log.info("Update ${objectName}={}", ${objectName});
        return ${objectName}Dao.update(${objectName});
    }

    @Override
    public int delete${className}(Long id) {
        log.info("Delete ${objectName}, id={}", id);
        return ${objectName}Dao.delete(id);
    }
}
