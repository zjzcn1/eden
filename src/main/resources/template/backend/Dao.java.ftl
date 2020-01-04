package ${packageName}.dao;

import java.util.List;
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

    List<${className}> findAll();

    Page<${className}> findByPageable(Pageable pageable);

    Long insert(${className} ${objectName});

    int update(${className} ${objectName});

    int delete(Long id);

}