package ${packageName}.controller;

import java.util.List;
import java.util.Map;
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

    @RequestMapping(path = "${table.objectName}/create", method = RequestMethod.POST)
    @ResponseBody
    public Result<${table.className}> create(@RequestBody ${table.className} ${table.objectName}) {
        ${table.objectName}Service.insert(${table.objectName});
        return Result.success();
    }

    @RequestMapping(path = "${table.objectName}/update", method = RequestMethod.PUT)
    @ResponseBody
    public Result<Void> update${table.className}(@RequestBody ${table.className} ${table.objectName}) {
        ${table.objectName}Service.update(${table.objectName});
        return Result.success();
    }

    @RequestMapping(path = "${table.objectName}/delete", method = RequestMethod.DELETE)
    @ResponseBody
    public Result<Void> delete${table.className}(Long id) {
        ${table.objectName}Service.delete(id);
        return Result.success();
    }

    @RequestMapping(path = "${table.objectName}/get", method = RequestMethod.GET)
    @ResponseBody
    public Result<${table.className}> get(Long id) {
        ${table.className} obj = ${table.objectName}Service.getById(id);
        return Result.success(obj);
    }

    @RequestMapping(path = "${table.objectName}/count", method = RequestMethod.POST)
    @ResponseBody
    public Result<Integer> count(Map<String, Object> params) {
        int count = ${table.objectName}Service.count(params);
        return Result.success(count);
    }

    @RequestMapping(path = "${table.objectName}/list", method = RequestMethod.POST)
    @ResponseBody
    public Result<List<${table.className}>> list(Map<String, Object> params) {
        List<${table.className}> list = ${table.objectName}Service.list(params);
        return Result.success(list);
    }

    @RequestMapping(path = "${table.objectName}/page", method = RequestMethod.POST)
    @ResponseBody
    public Result<Page<${table.className}>> page(@RequestBody Pageable pageable) {
        Page<${table.className}> page = ${table.objectName}Service.page(pageable);
        return Result.success(page);
    }
}