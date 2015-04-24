package neu.cs5200.otr.dao;

import neu.cs5200.otr.entity.Comment;

import java.sql.*;
import java.util.ArrayList;

/**
 * Created by shunlin on 3/21/15.
 */
public class CommentDAO extends PostDAO {
    public int createComment(Comment comment) {
        int postId = createPost(comment);
        if (postId < 0) return -1;

        String sql = "INSERT INTO Comment(postId, relatedNoteId) VALUES(?, ?)";
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, postId);
            stmt.setInt(2, comment.getRelatedNoteId());
            stmt.executeUpdate();
            conn.close();
            return postId;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public boolean deleteCommentByCommentId(int commentId) {
        return deletePostByPostId(commentId);
    }

    public ArrayList<Comment> getCommentsByUserId(int pageNumber, int pageSize, int userId) {
        String sql = "SELECT * FROM Comment AS C, Post AS P WHERE C.postId = P.postId AND P.userId = ? " +
                "ORDER BY addTime DESC LIMIT ? , ?";
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, (pageNumber - 1) * pageSize);
            stmt.setInt(3, pageSize);
            ArrayList<Comment> results = getComments(stmt);
            conn.close();
            return results;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<Comment> getCommentsByNoteId(int pageNumber, int pageSize, int noteId) {
        String sql = "SELECT * FROM Comment AS C, Post AS P WHERE C.postId = P.postId AND C.relatedNoteId = ? " +
                "ORDER BY addTime DESC LIMIT ? , ?";
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, noteId);
            stmt.setInt(2, (pageNumber - 1) * pageSize);
            stmt.setInt(3, pageSize);
            ArrayList<Comment> results = getComments(stmt);
            conn.close();
            return results;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<Comment> getComments(PreparedStatement stmt) throws SQLException{
        ArrayList<Comment> results = new ArrayList<Comment>();
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            Comment comment = new Comment(
                    rs.getInt("postId"),
                    rs.getInt("userId"),
                    rs.getString("content"),
                    rs.getDate("addTime"),
                    rs.getInt("relatedNoteId")
            );
            results.add(comment);
        }
        return results;
    }

    public Comment getCommentByCommentId(int commentId) {
        String sql = "SELECT * FROM Comment AS C, Post AS P WHERE C.postId = P.postId AND C.postId = ? ";
        Comment comment = null;
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, commentId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                comment = new Comment(
                        rs.getInt("postId"),
                        rs.getInt("userId"),
                        rs.getString("content"),
                        rs.getDate("addTime"),
                        rs.getInt("relatedNoteId")
                );
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comment;
    }
}
