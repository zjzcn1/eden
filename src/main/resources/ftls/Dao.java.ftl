package ${packageName}.dao;

import ${packageName}.common.Page;
import ${packageName}.common.Pageable;
import ${packageName}.entity.${className};
import org.apache.ibatis.annotations.Mapper;

/**
 * Date  ${date}
 */
@Mapper
public interface ${className}Dao {

    ${className} getById(Long id);

    Page<${className}> findByPageable(Pageable pageable);

    Long insert(${className} ${objectName});

    int update(${className} ${objectName});

    int delete(Long id);

}