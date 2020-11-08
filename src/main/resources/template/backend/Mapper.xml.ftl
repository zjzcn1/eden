<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${packageName}.dao.${table.className}Dao">

    <sql id="Base_Column_List">
        ${baseColumnNames}
    </sql>

    <insert id="insert" parameterType="${packageName}.entity.${table.className}" useGeneratedKeys="true" keyProperty="id">
        insert into ${table.tableName}(
            ${insertColumnNames}
        )
        values (
            ${insertColumnValues}
        )
    </insert>

    <update id="update" parameterType="${packageName}.entity.${table.className}">
        update ${table.tableName}
        set
            ${updateColumnValues}
        where ${primaryKeyColumn} = ${primaryKeyProperty}
    </update>

<#if deletedColumn??>
    <update id="delete">
        update ${table.tableName} set ${deletedColumn} = REPLACE(unix_timestamp(now(3)),'.','')
        where ${primaryKeyColumn} = ${primaryKeyProperty}
    </update>
<#else>
    <delete id="delete">
        delete from ${table.tableName}
        where ${primaryKeyColumn} = ${primaryKeyProperty}
    </delete>
</#if>

    <select id="getById" resultType="${packageName}.entity.${table.className}">
        select
        <include refid="Base_Column_List" />
        from ${table.tableName}
        <where>
            ${primaryKeyColumn} = ${r"#{"}id${r"}"}
        </where>
    </select>

    <select id="getListByIds" resultType="${packageName}.entity.${table.className}">
        select
        <include refid="Base_Column_List" />
        from ${table.tableName}
        <where>
            ${primaryKeyColumn} in
            <foreach collection="ids" item="id" open="(" separator="," close=")">
                ${r"#{"}id${r"}"}
            </foreach>
        </where>
    </select>

    <select id="count" resultType="int">
        select
            count(*)
        from ${table.tableName}
        <where>
            1 = 1
            <foreach item="param" collection="params">
                and ${r"${"}param.field{r"}"} ${r"${"}param.op{r"}"} ${r"#{"}param.value${r"}"}
            </foreach>
            <#if deletedColumn??>
            and ${deletedColumn} = 0
            </#if>
        </where>
    </select>

    <select id="list" resultType="${packageName}.entity.${table.className}">
        select
        <include refid="Base_Column_List"/>
        from ${table.tableName}
        <where>
            1 = 1
            <foreach item="param" collection="params">
                and ${r"${"}param.field{r"}"} ${r"${"}param.op{r"}"} ${r"#{"}param.value${r"}"}
            </foreach>
            <#if deletedColumn??>
            and ${deletedColumn} = 0
            </#if>
        </where>
    </select>

    <select id="page" resultType="${packageName}.entity.${table.className}">
        select
        <include refid="Base_Column_List"/>
        from ${table.tableName}
        <where>
            1 = 1
            <foreach item="param" collection="params">
                and ${r"${"}param.field{r"}"} ${r"${"}param.op{r"}"} ${r"#{"}param.value${r"}"}
            </foreach>
            <#if deletedColumn??>
            and ${deletedColumn} = 0
            </#if>
        </where>
    </select>

</mapper>