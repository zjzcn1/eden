package com.github.zjzcn.test.common;

import org.apache.ibatis.binding.MapperMethod.ParamMap;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.executor.parameter.ParameterHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.MappedStatement.Builder;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.mapping.SqlSource;
import org.apache.ibatis.plugin.*;
import org.apache.ibatis.scripting.defaults.DefaultParameterHandler;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;


@Component
@Intercepts({
        @Signature(type = Executor.class, method = "query", args = {
                MappedStatement.class, Object.class, RowBounds.class, ResultHandler.class
        })
})
public class PagePlugin implements Interceptor {

    private static Logger log = LoggerFactory.getLogger(com.github.zjzcn.test.common.PagePlugin.class);

    private static final int MAPPED_STATEMENT_INDEX = 0;
    private static final int PARAMETER_INDEX = 1;
    private static final int ROWBOUNDS_INDEX = 2;

    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        final Object[] queryArgs = invocation.getArgs();
        final Object parameter = queryArgs[PARAMETER_INDEX];

        com.github.zjzcn.test.common.Pageable pageable = findObjectFromParams(parameter, com.github.zjzcn.test.common.Pageable.class);
        if(pageable == null) {
            return invocation.proceed();
        }

        final MappedStatement ms = (MappedStatement)queryArgs[MAPPED_STATEMENT_INDEX];
        final BoundSql boundSql = ms.getBoundSql(parameter);
        String sql = removeSqlSemicolon(boundSql.getSql().trim());

        int size = pageable.getSize();
        long total = queryTotal(sql, ms, boundSql);

        String pageSql = getPageSql(sql, (pageable.getCurrent()-1) * size, size);

        queryArgs[ROWBOUNDS_INDEX] = new RowBounds(RowBounds.NO_ROW_OFFSET, RowBounds.NO_ROW_LIMIT);
        queryArgs[MAPPED_STATEMENT_INDEX] = copyFromNewSql(ms, boundSql, pageSql);

        Object ret = invocation.proceed();

        Page<?> page = Page.of(pageable.getCurrent(), pageable.getSize(), total, (List<?>)ret);

        List<Page<?>> result = new ArrayList<>(1);
        result.add(page);

        return result;
    }

    @Override
    public Object plugin(Object target) {
        return Plugin.wrap(target, this);
    }

    @Override
    public void setProperties(Properties properties) {
        // NOOP
    }

    private String getPageSql(String sql, int offset, int limit) {
        StringBuilder sqlBuilder = new StringBuilder(sql);

        if(offset <= 0){
            return sqlBuilder.append(" limit ").append(limit).toString();
        }

        return sqlBuilder.append(" limit ").append(offset)
                .append(",").append(limit).toString();
    }

    private String getCountSql(String sql) {
        return "select count(*) from (" + sql + ") tmp_count";
    }

    /**
     * 在方法参数中查找 分页请求对象
     */
    @SuppressWarnings("unchecked")
    private <T> T findObjectFromParams(Object params, Class<T> objClass) {
        if (params == null) {
            return null;
        }

        if(objClass.isAssignableFrom(params.getClass())) {
            return (T) params;
        }

        if (params instanceof ParamMap) {
            ParamMap<Object> paramMap = (ParamMap<Object>) params;
            for (Map.Entry<String, Object> entry : paramMap.entrySet()) {
                Object paramValue = entry.getValue();

                if(paramValue != null && objClass.isAssignableFrom(paramValue.getClass())) {
                    return (T) paramValue;
                }
            }
        }

        return null;
    }

    /**
     * 查询总记录数
     */
    private long queryTotal(String sql, MappedStatement mappedStatement, BoundSql boundSql) throws SQLException {
        Connection connection = null;
        PreparedStatement countStmt = null;
        ResultSet rs = null;
        try {

            connection = mappedStatement.getConfiguration().getEnvironment().getDataSource().getConnection();

            String countSql = getCountSql(sql);

            countStmt = connection.prepareStatement(countSql);
            BoundSql countBoundSql = copyFromBoundSql(mappedStatement, boundSql, countSql);
            setParameters(countStmt, mappedStatement, countBoundSql, boundSql.getParameterObject());

            rs = countStmt.executeQuery();
            long totalCount = 0;
            if (rs.next()) {
                totalCount = rs.getLong(1);
            }

            return totalCount;
        } catch (SQLException e) {
            log.error("查询总记录数出错", e);
            throw e;
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    log.error("exception happens when doing: ResultSet.close()", e);
                }
            }

            if (countStmt != null) {
                try {
                    countStmt.close();
                } catch (SQLException e) {
                    log.error("exception happens when doing: PreparedStatement.close()", e);
                }
            }

            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    log.error("exception happens when doing: Connection.close()", e);
                }
            }
        }

    }

    private MappedStatement copyFromNewSql(MappedStatement ms,
                                                 BoundSql boundSql, String sql) {
        BoundSql newBoundSql = copyFromBoundSql(ms, boundSql, sql);

        return copyFromMappedStatement(ms, new SqlSource() {
            @Override
            public BoundSql getBoundSql(Object parameterObject) {
                return newBoundSql;
            }
        });
    }

    /**
     * 删除sql中的分号
     */
    private String removeSqlSemicolon(String sql) {
        final StringBuilder sqlBuilder = new StringBuilder(sql);
        if(sqlBuilder.lastIndexOf(";") == sqlBuilder.length()-1){
            sqlBuilder.deleteCharAt(sqlBuilder.length()-1);
        }

        return sqlBuilder.toString();
    }

    /*
     * 对SQL参数(?)设值
     */
    private void setParameters(PreparedStatement ps, MappedStatement mappedStatement, BoundSql boundSql,
                                      Object parameterObject) throws SQLException {
        ParameterHandler parameterHandler = new DefaultParameterHandler(mappedStatement, parameterObject, boundSql);
        parameterHandler.setParameters(ps);
    }

    private static BoundSql copyFromBoundSql(MappedStatement ms, BoundSql boundSql,
                                             String sql) {
        BoundSql newBoundSql = new BoundSql(ms.getConfiguration(),sql, boundSql.getParameterMappings(), boundSql.getParameterObject());
        for (ParameterMapping mapping : boundSql.getParameterMappings()) {
            String prop = mapping.getProperty();
            if (boundSql.hasAdditionalParameter(prop)) {
                newBoundSql.setAdditionalParameter(prop, boundSql.getAdditionalParameter(prop));
            }
        }
        return newBoundSql;
    }

    //see: MapperBuilderAssistant
    private MappedStatement copyFromMappedStatement(MappedStatement ms, SqlSource newSqlSource) {
        Builder builder = new Builder(ms.getConfiguration(),ms.getId(),newSqlSource,ms.getSqlCommandType());

        builder.resource(ms.getResource());
        builder.fetchSize(ms.getFetchSize());
        builder.statementType(ms.getStatementType());
        builder.keyGenerator(ms.getKeyGenerator());
        if(ms.getKeyProperties() != null && ms.getKeyProperties().length !=0){
            StringBuilder keyProperties = new StringBuilder();
            for(String keyProperty : ms.getKeyProperties()){
                keyProperties.append(keyProperty).append(",");
            }
            keyProperties.delete(keyProperties.length()-1, keyProperties.length());
            builder.keyProperty(keyProperties.toString());
        }

        //setStatementTimeout()
        builder.timeout(ms.getTimeout());

        //setStatementResultMap()
        builder.parameterMap(ms.getParameterMap());

        //setStatementResultMap()
        builder.resultMaps(ms.getResultMaps());
        builder.resultSetType(ms.getResultSetType());

        //setStatementCache()
        builder.cache(ms.getCache());
        builder.flushCacheRequired(ms.isFlushCacheRequired());
        builder.useCache(ms.isUseCache());

        return builder.build();
    }
}