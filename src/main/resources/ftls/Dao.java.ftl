package ${daoPackageName};

import ${entityPackageName}.${className};
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * Date  ${date}
 */
@Mapper
public interface ${className}Dao {

    public ${className} get(Long id);

    public List<${className}> findList(${className} ${objectName});

    public List<${className}> findAllList();

    public int insert(${className} ${objectName});

    public int insertBatch(List<${className}> ${objectName}s);

    public int update(${className} ${objectName});

    public int delete(${className} ${objectName});

}