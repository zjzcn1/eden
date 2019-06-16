package ${packageName}.controller;

import ${packageName}.common.Page;
import ${packageName}.common.Pageable;
import ${packageName}.common.Result;
import ${packageName}.entity.${className};
import ${packageName}.service.${className}Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * Date  ${date}
 */
@RestController
public class ${className}Controller {

    @Autowired
    private ${className}Service ${objectName}Service;

    @RequestMapping(path = "list${className}", method = RequestMethod.POST)
    @ResponseBody
    public Result<Page<${className}>> list${className}(@RequestBody Pageable pageable) {
        Page<${className}> page =${objectName}Service.findByPageable(pageable);
        return Result.ok(page);
    }

    @RequestMapping(path = "add${className}", method = RequestMethod.POST)
    @ResponseBody
    public Result<${className}> add${className}(@RequestBody ${className} ${objectName}) {
        ${objectName}Service.insert${className}(${objectName});
        return Result.ok();
    }

    @RequestMapping(path = "update${className}", method = RequestMethod.PUT)
    @ResponseBody
    public Result<Void> update${className}(@RequestBody ${className} ${objectName}) {
        ${objectName}Service.update${className}(${objectName});
        return Result.ok();
    }

    @RequestMapping(path = "delete${className}", method = RequestMethod.DELETE)
    @ResponseBody
    public Result<Void> delete${className}(Long id) {
        ${objectName}Service.delete${className}(id);
        return Result.ok();
    }

}