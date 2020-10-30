package ${packageName}.service;


import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import ${packageName}.entity.${table.className};
import ${packageName}.dao.${table.className}Dao;
import ${packageName}.common.BaseServiceImpl;
import ${packageName}.service.${table.className}Service;

/**
 * Date  ${date}
 */
@Slf4j
@Service
public class ${table.className}ServiceImpl extends BaseServiceImpl<${table.className}, ${table.className}Dao> implements ${table.className}Service {

}
