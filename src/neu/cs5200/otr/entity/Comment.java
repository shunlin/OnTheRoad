package neu.cs5200.otr.entity;

import java.sql.Date;

/**
 * Created by shunlin on 3/21/15.
 */
public class Comment extends Post {
    private int relatedNoteId;

    public Comment(int userId, String content, int relatedNoteId) {
        this.postId = -1;
        this.userId = userId;
        this.content = content;
        this.relatedNoteId = relatedNoteId;
    }

    public Comment(int postId, int userId, String content, Date addTime, int relatedNoteId) {
        this.postId = postId;
        this.userId = userId;
        this.content = content;
        this.addTime = addTime;
        this.relatedNoteId = relatedNoteId;
    }

    public int getRelatedNoteId() {
        return relatedNoteId;
    }
}
