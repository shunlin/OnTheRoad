package neu.cs5200.otr.entity;

import java.sql.Date;

/**
 * Created by shunlin on 3/21/15.
 */
public abstract class Post {
    protected int postId;
    protected int userId;
    protected String content;
    protected Date addTime;

    public int getPostId() {
        return postId;
    }

    public int getUserId() {
        return userId;
    }

    public String getContent() {
        return content;
    }

    public Date getAddTime() {
        return addTime;
    }

}
