package com.github.zjzcn.test.dao;

import com.github.zjzcn.test.common.Page;
import com.github.zjzcn.test.common.Pageable;
import com.github.zjzcn.test.entity.User;
import org.apache.ibatis.annotations.Mapper;

/**
 * Date  2019-06-16
 */
@Mapper
public interface UserDao {

    public User getById(Long id);

    public Page<User> findByPageable(Pageable pageable);

    public Long insert(User user);

    public int update(User user);

    public int delete(Long id);

}