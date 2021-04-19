package ${packageName}.common;

import lombok.Data;

import java.util.HashMap;

@Data
public class MapParam extends HashMap<String, Object> {

    public String getString(String key) {
        Object value = get(key);
        if (value == null) {
            return null;
        }
        return value.toString();
    }

    public Integer getInteger(String key) {
        Object value = get(key);
        if (value == null) {
            return null;
        }
        if (value instanceof Integer) {
            return (Integer) value;
        }
        if (value instanceof Long) {
            return ((Long) value).intValue();
        }
        if (value instanceof String) {
            return Integer.valueOf((String) value);
        }
        throw new RuntimeException("Can not convert Integer type, key=" + key + ", value" + value);
    }

    public Long getLong(String key) {
        Object value = get(key);
        if (value == null) {
            return null;
        }
        if (value instanceof Integer) {
            return ((Integer) value).longValue();
        }
        if (value instanceof Long) {
            return (Long) value;
        }
        if (value instanceof String) {
            return Long.valueOf((String) value);
        }
        throw new RuntimeException("Can not convert Long type, key=" + key + ", value" + value);
    }
}
