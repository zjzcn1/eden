<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${daoPackageName}.${className}Dao">

    <sql id="Base_Column_List">
        ${tableColumnNames}
    </sql>

    <select id="get" resultType="${entityPackageName}.${className}">
        SELECT
        <include refid="Base_Column_List" />
        FROM ${tableName}
        <where>
        ${tableName}.${primaryKey} = ${primaryKeyProperty}
        </where>
    </select>

    <select id="findList" resultType="${entityPackageName}.${className}">
        SELECT
        <include refid="Base_Column_List" />
        FROM ${tableName}
        <where>
            <#-- AND ${tableName}.name LIKE concat('%',#{name},'%')-->
        </where>
    </select>

    <select id="findAllList" resultType="${entityPackageName}.${className}">
        SELECT
        <include refid="Base_Column_List" />
        FROM ${tableName}
        <where>
        </where>
    </select>

    <insert id="insert">
        INSERT INTO ${tableName}(
            ${tableColumnNames}
        )
        VALUES (
            ${tableColumnValues}
        )
    </insert>

    <update id="update">
        UPDATE ${tableName} SET
        ${updateProperties}
        WHERE ${primaryKey} = ${primaryKeyProperty}
    </update>

    <update id="delete">
        DELETE FROM ${tableName}
        WHERE ${primaryKey} = ${primaryKeyProperty}
    </update>

</mapper>