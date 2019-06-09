package ${servicePackageName};

import ${entityPackageName}.${className};

import java.util.List;

/**
 * Date  ${date}
 */
public interface ${className}Service {

    public ${className} get(String id);

    public List<${className}> findList(${className} ${objectName});

    public List<${className}> findAllList();

    public int insert(${className} ${objectName});

    public int insertBatch(List<${className}> ${objectName}s);

    public int update(${className} ${objectName});

    public int delete(${className} ${objectName});

}
