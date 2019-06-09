
import lombok.Data;

@Data
public class Pageable {
    public static final String NumberEq = "NumberEq";
    public static final String StringEq = "StringEq";
    public static final String LeftLike = "LeftLike";
    public static final String RightLike = "RightLike";
    public static final String Like = "Like";

    private Integer size;
    private Integer current;
    private String filterName;
    private String filterValue;
    private String filterCond;

}
