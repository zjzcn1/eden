package ${packageName}.common;


import org.apache.commons.lang3.StringUtils;

import java.util.ArrayList;
import java.util.List;

public class QueryBuilder {

    private List<QueryCondition> params = new ArrayList<>();

    private QueryBuilder() {
    }

    public static QueryBuilder create() {
        return new QueryBuilder();
    }

    public List<QueryCondition> build() {
        return params;
    }

    public QueryBuilder eq(String field, Object value) {
        if (StringUtils.isNotBlank(field) && value != null) {
            params.add(new QueryCondition(field, value, " = "));
        }
        return this;
    }

    public QueryBuilder ne(String field, Object value) {
        if (StringUtils.isNotBlank(field) && value != null) {
            params.add(new QueryCondition(field, value, "! = "));
        }
        return this;
    }

    public QueryBuilder lt(String field, Object value) {
        if (StringUtils.isNotBlank(field) && value != null) {
            params.add(new QueryCondition(field, value, " < "));
        }
        return this;
    }

    public QueryBuilder le(String field, Object value) {
        if (StringUtils.isNotBlank(field) && value != null) {
            params.add(new QueryCondition(field, value, " <= "));
        }
        return this;
    }

    public QueryBuilder gt(String field, Object value) {
        if (StringUtils.isNotBlank(field) && value != null) {
            params.add(new QueryCondition(field, value, " > "));
        }
        return this;
    }

    public QueryBuilder ge(String field, Object value) {
        if (StringUtils.isNotBlank(field) && value != null) {
            params.add(new QueryCondition(field, value, " >= "));
        }
        return this;
    }

    public QueryBuilder like(String field, Object value) {
        if (StringUtils.isNotBlank(field) && value != null) {
            params.add(new QueryCondition(field, "%" + value + "%", " like "));
        }
        return this;
    }

    public QueryBuilder likeLeft(String field, Object value) {
        if (StringUtils.isNotBlank(field) && value != null) {
            params.add(new QueryCondition(field, "%" + value, " like "));
        }
        return this;
    }

    public QueryBuilder likeRight(String field, Object value) {
        if (StringUtils.isNotBlank(field) && value != null) {
            params.add(new QueryCondition(field, value + "%", " like "));
        }
        return this;
    }

}

