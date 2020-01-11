<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${packageName}.dao.${table.className}Dao">

    <sql id="Base_Column_List">
        ${baseColumnNames}
    </sql>

    <select id="getById" resultType="${packageName}.entity.${table.className}">
        select
        <include refid="Base_Column_List" />
        from ${table.tableName}
        <where>
            ${table.tableName}.${primaryKeyColumn} = ${primaryKeyProperty}
        </where>
    </select>

    <select id="findAll" resultType="${packageName}.entity.${table.className}">
        select
        <include refid="Base_Column_List"/>
        from ${table.tableName}
        <where>
            <#if deletedColumn??>
            ${deletedColumn} = 0
            </#if>
        </where>
    </select>

    <select id="findByPageable" resultType="${packageName}.entity.${table.className}">
        select
        <include refid="Base_Column_List"/>
        from ${table.tableName}
        <where>
            <#if deletedColumn??>
            ${deletedColumn} = 0
            </#if>
            <if test="params.queryName != '' and params.queryValue != ''">
                and ${r"${"}params.queryName${r"}"} = ${r"#{"}params.queryValue${r"}"}
            </if>
        </where>
    </select>

    <insert id="insert" parameterType="${packageName}.entity.${table.className}" useGeneratedKeys="true" keyProperty="id">
        insert into ${table.tableName}(
            ${insertColumnNames}
        )
        values (
            ${insertColumnValues}
        )
    </insert>

    <update id="update" parameterType="${packageName}.entity.${table.className}">
        update ${table.tableName} set
        ${updateColumnValues}
        WHERE ${primaryKeyColumn} = ${primaryKeyProperty}
    </update>

<#if deletedColumn??>
    <update id="delete">
        update ${table.tableName} set ${deletedColumn} = 1
        where ${primaryKeyColumn} = ${primaryKeyProperty}
    </update>
<#else>
    <delete id="delete">
        delete from ${table.tableName}
        where ${primaryKeyColumn} = ${primaryKeyProperty}
    </delete>
</#if>
</mapper>