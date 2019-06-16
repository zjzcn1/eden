package com.github.zjzcn.test.entity;

import lombok.Data;
import java.io.Serializable;
import java.util.List;
import java.util.Date;
import java.math.BigDecimal;

/**
 * Date  2019-06-16
 */
@Data
public class User implements Serializable {
private static final long serialVersionUID = 1L;

    private Long id;
    private String username;
    private String password;
    private Date createTime;
    private Integer enabled;
    private Integer deleted;


}