package neu.cs5200.otr.entity;

import java.sql.Date;

/**
 * Created by shunlin on 3/21/15.
 */
public class Note extends Post {
    private int locationId;
    private int score;
    private String title;

    public Note(int postId, int userId, String content, Date addTime, int locationId, int score, String title) {
        this.postId = postId;
        this.userId = userId;
        this.content = content;
        this.addTime = addTime;
        this.locationId = locationId;
        this.score = score;
        this.title = title;
    }

    public Note(int userId, String content, int locationId, int score, String title) {
        this.userId = userId;
        this.content = content;
        this.locationId = locationId;
        this.score = score;
        this.title = title;
    }

    public int getLocationId() {
        return locationId;
    }

    public int getScore() {
        return score;
    }

    public String getTitle() {
        return title;
    }

}
