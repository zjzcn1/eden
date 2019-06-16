package com.github.zjzcn.test.service;


import com.github.zjzcn.test.common.Page;
import com.github.zjzcn.test.common.Pageable;
import com.github.zjzcn.test.entity.User;

/**
 * Date  2019-06-16
 */
public interface UserService {

    public User getUser(Long id);

    public Page<User> findByPageable(Pageable pageable);

    public Long insertUser(User user);

    public int updateUser(User user);

    public int deleteUser(Long id);

}
