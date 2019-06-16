<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${packageName}.dao.${className}Dao">

    <sql id="Base_Column_List">
        ${tableColumnNames}
    </sql>

    <select id="getById" resultType="${packageName}.entity.${className}">
        SELECT
        <include refid="Base_Column_List" />
        FROM ${tableName}
        <where>
            ${tableName}.${primaryKey} = ${primaryKeyValue}
        </where>
    </select>

    <select id="findByPageable" resultType="${packageName}.entity.${className}">
        select
        <include refid="Base_Column_List"/>
        from ${tableName}
        <where>
        </where>
    </select>

    <insert id="insert" parameterType="${packageName}.entity.${className}" useGeneratedKeys="true" keyProperty="id">
        INSERT INTO ${tableName}(
            ${tableColumnNames}
        )
        VALUES (
            ${tableColumnValues}
        )
    </insert>

    <update id="update" parameterType="${packageName}.entity.${className}">
        UPDATE ${tableName} SET
        ${updateProperties}
        WHERE ${primaryKey} = ${primaryKeyValue}
    </update>

    <update id="delete">
        DELETE FROM ${tableName}
        WHERE ${primaryKey} = ${primaryKeyValue}
    </update>

</mapper>