package ${packageName}.controller;

import ${packageName}.common.Page;
import ${packageName}.common.PageParam;
import ${packageName}.common.MapParam;
import ${packageName}.common.Result;
import ${packageName}.entity.${table.className};
import ${packageName}.service.${table.className}Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Date  ${date}
 */
@RestController
public class ${table.className}Controller {

    @Autowired
    private ${table.className}Service ${table.objectName}Service;

    @RequestMapping(path = "${table.objectName}/create", method = RequestMethod.POST)
    @ResponseBody
    public Result<Long> create(@RequestBody ${table.className} ${table.objectName}) {
        Long id = ${table.objectName}Service.create${table.className}(${table.objectName});
        return Result.success(id);
    }

    @RequestMapping(path = "${table.objectName}/update", method = RequestMethod.PUT)
    @ResponseBody
    public Result<Void> update${table.className}(@RequestBody ${table.className} ${table.objectName}) {
        ${table.objectName}Service.update${table.className}(${table.objectName});
        return Result.success();
    }

    @RequestMapping(path = "${table.objectName}/delete", method = RequestMethod.DELETE)
    @ResponseBody
    public Result<Void> delete${table.className}(Long id) {
        ${table.objectName}Service.delete${table.className}(id);
        return Result.success();
    }

    @RequestMapping(path = "${table.objectName}/get", method = RequestMethod.GET)
    @ResponseBody
    public Result<${table.className}> get(Long id) {
        ${table.className} obj = ${table.objectName}Service.get${table.className}ById(id);
        return Result.success(obj);
    }

    @RequestMapping(path = "${table.objectName}/count", method = RequestMethod.POST)
    @ResponseBody
    public Result<Integer> count(@RequestBody MapParam params) {
        int count = ${table.objectName}Service.count${table.className}(params);
        return Result.success(count);
    }

    @RequestMapping(path = "${table.objectName}/list", method = RequestMethod.POST)
    @ResponseBody
    public Result<List<${table.className}>> list(@RequestBody MapParam params) {
        List<${table.className}> list = ${table.objectName}Service.list${table.className}(params);
        return Result.success();
    }

    @RequestMapping(path = "${table.objectName}/page", method = RequestMethod.POST)
    @ResponseBody
    public Result<Page<${table.className}>> page(@RequestBody PageParam params) {
        Page<${table.className}> page = ${table.objectName}Service.page${table.className}(params);
        return Result.success(page);
    }

}