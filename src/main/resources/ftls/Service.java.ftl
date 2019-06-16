package ${packageName}.service;


import ${packageName}.common.Page;
import ${packageName}.common.Pageable;
import ${packageName}.entity.${className};

/**
 * Date  ${date}
 */
public interface ${className}Service {

    public ${className} get${className}(Long id);

    public Page<${className}> findByPageable(Pageable pageable);

    public Long insert${className}(${className} ${objectName});

    public int update${className}(${className} ${objectName});

    public int delete${className}(Long id);

}
