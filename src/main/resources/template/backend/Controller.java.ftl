package ${packageName}.controller;

import java.util.List;
import ${packageName}.common.Page;
import ${packageName}.common.Pageable;
import ${packageName}.common.Result;
import ${packageName}.entity.${table.className};
import ${packageName}.service.${table.className}Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * Date  ${date}
 */
@RestController
public class ${table.className}Controller {

    @Autowired
    private ${table.className}Service ${table.objectName}Service;

    @RequestMapping(path = "${table.objectName}/listAll${table.className}", method = RequestMethod.POST)
    @ResponseBody
    public Result<List<${table.className}>> listAll${table.className}() {
        List<${table.className}> list =${table.objectName}Service.findAll${table.className}();
        return Result.success(list);
    }

    @RequestMapping(path = "${table.objectName}/list${table.className}", method = RequestMethod.POST)
    @ResponseBody
    public Result<Page<${table.className}>> list${table.className}(@RequestBody Pageable pageable) {
        Page<${table.className}> page =${table.objectName}Service.findByPageable(pageable);
        return Result.success(page);
    }

    @RequestMapping(path = "${table.objectName}/create${table.className}", method = RequestMethod.POST)
    @ResponseBody
    public Result<${table.className}> add${table.className}(@RequestBody ${table.className} ${table.objectName}) {
        ${table.objectName}Service.insert${table.className}(${table.objectName});
        return Result.success();
    }

    @RequestMapping(path = "${table.objectName}/update${table.className}", method = RequestMethod.PUT)
    @ResponseBody
    public Result<Void> update${table.className}(@RequestBody ${table.className} ${table.objectName}) {
        ${table.objectName}Service.update${table.className}(${table.objectName});
        return Result.success();
    }

    @RequestMapping(path = "${table.objectName}/delete${table.className}", method = RequestMethod.DELETE)
    @ResponseBody
    public Result<Void> delete${table.className}(Long id) {
        ${table.objectName}Service.delete${table.className}(id);
        return Result.success();
    }

}