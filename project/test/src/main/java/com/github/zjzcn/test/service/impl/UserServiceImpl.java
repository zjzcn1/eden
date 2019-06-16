package com.github.zjzcn.test.service.impl;

import com.github.zjzcn.test.common.Page;
import com.github.zjzcn.test.common.Pageable;
import com.github.zjzcn.test.entity.User;
import com.github.zjzcn.test.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Date  2019-06-15
 */
@Slf4j
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private com.github.zjzcn.test.dao.UserDao userDao;

    @Override
    public User getUser(Long id) {
        return userDao.getById(id);
    }

    @Override
    public Page<User> findByPageable(Pageable pageable) {
        return userDao.findByPageable(pageable);
    }

    @Override
    public Long insertUser(User user) {
        log.info("Insert user={}", user);
        return userDao.insert(user);
    }

    @Override
    public int updateUser(User user) {
        log.info("Update user={}", user);
        return userDao.update(user);
    }

    @Override
    public int deleteUser(Long id) {
        log.info("Delete user, id={}", id);
        return userDao.delete(id);
    }
}
