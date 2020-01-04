<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${packageName}.dao.${className}Dao">

    <sql id="Base_Column_List">
        ${tableColumnNames}
    </sql>

    <select id="getById" resultType="${packageName}.entity.${className}">
        select
        <include refid="Base_Column_List" />
        from ${tableName}
        <where>
            ${tableName}.${primaryKey} = ${primaryKeyValue}
        </where>
    </select>

    <select id="findAll" resultType="${packageName}.entity.${className}">
        select
        <include refid="Base_Column_List"/>
        from ${tableName}
        <where>
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
        insert into ${tableName}(
            ${tableColumnNames}
        )
        values (
            ${tableColumnValues}
        )
    </insert>

    <update id="update" parameterType="${packageName}.entity.${className}">
        update ${tableName} set
        ${updateProperties}
        WHERE ${primaryKey} = ${primaryKeyValue}
    </update>

    <delete id="delete">
        delete from ${tableName}
        where ${primaryKey} = ${primaryKeyValue}
    </delete>

</mapper>