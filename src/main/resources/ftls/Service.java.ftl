package ${packageName}.service;


import ${packageName}.common.Page;
import ${packageName}.common.Pageable;
import ${packageName}.entity.${className};

/**
 * Date  ${date}
 */
public interface ${className}Service {

    ${className} get${className}(Long id);

    Page<${className}> findByPageable(Pageable pageable);

    Long insert${className}(${className} ${objectName});

    int update${className}(${className} ${objectName});

    int delete${className}(Long id);

}
