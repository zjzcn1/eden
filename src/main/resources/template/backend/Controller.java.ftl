package ${packageName}.controller;

import java.util.List;
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

    @RequestMapping(path = "${objectName}/listAll${className}", method = RequestMethod.POST)
    @ResponseBody
    public Result<List<${className}>> listAll${className}() {
        List<${className}> list =${objectName}Service.findAll${className}();
        return Result.success(list);
    }

    @RequestMapping(path = "${objectName}/list${className}", method = RequestMethod.POST)
    @ResponseBody
    public Result<Page<${className}>> list${className}(@RequestBody Pageable pageable) {
        Page<${className}> page =${objectName}Service.findByPageable(pageable);
        return Result.success(page);
    }

    @RequestMapping(path = "${objectName}/create${className}", method = RequestMethod.POST)
    @ResponseBody
    public Result<${className}> add${className}(@RequestBody ${className} ${objectName}) {
        ${objectName}Service.insert${className}(${objectName});
        return Result.success();
    }

    @RequestMapping(path = "${objectName}/update${className}", method = RequestMethod.PUT)
    @ResponseBody
    public Result<Void> update${className}(@RequestBody ${className} ${objectName}) {
        ${objectName}Service.update${className}(${objectName});
        return Result.success();
    }

    @RequestMapping(path = "${objectName}/delete${className}", method = RequestMethod.DELETE)
    @ResponseBody
    public Result<Void> delete${className}(Long id) {
        ${objectName}Service.delete${className}(id);
        return Result.success();
    }

}