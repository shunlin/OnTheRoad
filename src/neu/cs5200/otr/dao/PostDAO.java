package neu.cs5200.otr.dao;

import neu.cs5200.otr.entity.Post;
import java.sql.*;

/**
 * Created by shunlin on 3/21/15.
 */
public abstract class PostDAO extends DAO {
    public int createPost(Post p) {
        String sql = "INSERT INTO `Post`(userId, content) VALUES(?, ?)";
        int postId = -1;
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, p.getUserId());
            stmt.setString(2, p.getContent());
            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) postId = rs.getInt(1);
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return postId;
    }

    public boolean deletePostByPostId(int postId) {
        String sql = "DELETE FROM `Post` WHERE postId = ?";
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, postId);
            stmt.executeUpdate();
            conn.close();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
