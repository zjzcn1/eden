package ${controllerPackageName};

import ${entityPackageName}.${className};
import ${servicePackageName}.${className}Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * Date  ${date}
 */
@RestController
@RequestMapping(value = "/${tableName}")
public class ${className}Controller {
    @Autowired
    private ${className}Service ${objectName}Service;

    @RequestMapping(value = {"/list", ""}, method = RequestMethod.GET)
    public Object list() {
        List<${className}> ${objectName}s = ${objectName}Service.findAllList();
        return ${objectName}s;
    }

    @RequestMapping(value = {"/get"}, method = RequestMethod.GET)
    public Object get(@RequestParam String id) {
        ${className} ${objectName} = ${objectName}Service.get(id);
        return ${objectName};
    }

    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    public String insert(@RequestBody ${className} ${objectName}) {
        if (${objectName}Service.insert(${objectName}) > 0) {
            return "success";
        } else {
            return "failed";
        }
    }

    @RequestMapping(value = "/insertBatch", method = RequestMethod.POST)
    public String insertBatch(@RequestBody List<${className}> ${objectName}s) {
        if (${objectName}Service.insertBatch(${objectName}s) > 0) {
            return "success";
        } else {
            return "failed";
        }
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String update(@RequestBody ${className} ${objectName}) {
        if (${objectName}Service.update(${objectName}) > 0) {
            return "success";
        } else {
            return "failed";
        }
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public String delete(@RequestBody ${className} ${objectName}) {
        if (${objectName}Service.delete(${objectName}) > 0) {
            return "success";
        } else {
            return "failed";
        }
    }

}
