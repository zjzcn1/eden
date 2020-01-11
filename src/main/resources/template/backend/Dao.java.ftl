package ${packageName}.dao;

import java.util.List;
import ${packageName}.common.Page;
import ${packageName}.common.Pageable;
import ${packageName}.entity.${table.className};
import org.apache.ibatis.annotations.Mapper;

/**
 * Date  ${date}
 */
@Mapper
public interface ${table.className}Dao {

    ${table.className} getById(Long id);

    List<${table.className}> findAll();

    Page<${table.className}> findByPageable(Pageable pageable);

    Long insert(${table.className} ${table.objectName});

    int update(${table.className} ${table.objectName});

    int delete(Long id);

}