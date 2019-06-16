package ${packageName}.dao;

import ${packageName}.common.Page;
import ${packageName}.common.Pageable;
import c${packageName}.entity.${className};
import org.apache.ibatis.annotations.Mapper;

/**
 * Date  ${date}
 */
@Mapper
public interface ${className}Dao {

    public ${className} getById(Long id);

    public Page<${className}> findByPageable(Pageable pageable);

    public Long insert(${className} ${objectName});

    public int update(${className} ${objectName});

    public int delete(Long id);

}