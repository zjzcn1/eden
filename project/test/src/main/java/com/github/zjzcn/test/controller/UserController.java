package com.github.zjzcn.test.controller;

import com.github.zjzcn.test.common.Page;
import com.github.zjzcn.test.common.Pageable;
import com.github.zjzcn.test.common.Result;
import com.github.zjzcn.test.entity.User;
import com.github.zjzcn.test.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * Date  2019-06-16
 */
@RestController
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping(path = "listUser", method = RequestMethod.POST)
    @ResponseBody
    public Result<Page<User>> listUser(@RequestBody Pageable pageable) {
        Page<User> page =userService.findByPageable(pageable);
        return Result.ok(page);
    }

    @RequestMapping(path = "addUser", method = RequestMethod.POST)
    @ResponseBody
    public Result<User> addUser(@RequestBody User user) {
        userService.insertUser(user);
        return Result.ok();
    }

    @RequestMapping(path = "updateUser", method = RequestMethod.PUT)
    @ResponseBody
    public Result<Void> updateUser(@RequestBody User user) {
        userService.updateUser(user);
        return Result.ok();
    }

    @RequestMapping(path = "deleteUser", method = RequestMethod.DELETE)
    @ResponseBody
    public Result<Void> deleteUser(Long id) {
        userService.deleteUser(id);
        return Result.ok();
    }

}