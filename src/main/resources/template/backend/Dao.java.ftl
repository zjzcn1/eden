package ${packageName}.dao;

import org.apache.ibatis.annotations.Mapper;
import ${packageName}.common.BaseDao;
import ${packageName}.entity.${table.className};

/**
 * Date  ${date}
 */
@Mapper
public interface ${table.className}Dao extends BaseDao<${table.className}> {

}