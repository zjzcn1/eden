package ${serviceImplPackageName};

import ${daoPackageName}.${className}Dao;
import ${entityPackageName}.${className};
import ${servicePackageName}.${className}Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Date  ${date}
 */
@Service
public class ${className}ServiceImpl {
    @Autowired
    private ${className}Dao ${objectName}Dao;

    @Override
    public ${className} get(Long id){
        return ${objectName}Dao.get(id);
    }
    @Override
    public List<${className}> findList(${className} ${objectName}) {
        return ${objectName}Dao.findList(${objectName});
    }
    @Override
    public List<${className}> findAllList() {
        return ${objectName}Dao.findAllList();
    }
    @Override
    public int insert(${className} ${objectName}) {
        return ${objectName}Dao.insert(${objectName});
    }
    @Override
    public int insertBatch(List<${className}> ${objectName}s){
        return ${objectName}Dao.insertBatch(${objectName}s);
    }
    @Override
    public int update(${className} ${objectName}) {
        return ${objectName}Dao.update(${objectName});
    }
    @Override
    public int delete(${className} ${objectName}) {
        return ${objectName}Dao.delete(${objectName});
    }

}
