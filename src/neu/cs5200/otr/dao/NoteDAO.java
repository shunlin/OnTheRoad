package neu.cs5200.otr.dao;

import neu.cs5200.otr.entity.Note;

import java.sql.*;
import java.util.ArrayList;

/**
 * Created by shunlin on 3/21/15.
 */
public class NoteDAO extends PostDAO {
    public int createNote(Note note) {
        int postId = createPost(note);
        if (postId < 0) return -1;
        String sql = "INSERT INTO Note(postId, locationId, score, title) VALUES(?, ?, ?, ?)";
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, postId);
            stmt.setInt(2, note.getLocationId());
            stmt.setInt(3, note.getScore());
            stmt.setString(4, note.getTitle());
            stmt.executeUpdate();
            conn.close();
            return postId;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public boolean deleteNoteByNoteId(int noteId) {
        return deletePostByPostId(noteId);
    }

    public ArrayList<Note> getLatestNotes(int pageNumber, int pageSize) {
        String sql = "SELECT * FROM Note AS N, Post AS P WHERE N.postId = P.postId " +
                "ORDER BY addTime DESC LIMIT ? , ?";
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, (pageNumber - 1) * pageSize);
            stmt.setInt(2, pageSize);
            ArrayList<Note> results = getNotes(stmt);
            conn.close();
            return results;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<Note> getNotesByUserId(int pageNumber, int pageSize, int userId) {
        String sql = "SELECT * FROM Note AS N, Post AS P WHERE N.postId = P.postId AND P.userId = ? " +
                "ORDER BY addTime DESC LIMIT ? , ?";
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, (pageNumber - 1) * pageSize);
            stmt.setInt(3, pageSize);
            ArrayList<Note> results = getNotes(stmt);
            conn.close();
            return results;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;

    }

    public ArrayList<Note> getNotesByLocationId(int pageNumber, int pageSize, int locationId) {
        String sql = "SELECT * FROM Note AS N, Post AS P WHERE N.postId = P.postId AND N.locationId = ? " +
                "ORDER BY addTime DESC LIMIT ? , ?";
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, locationId);
            stmt.setInt(2, (pageNumber - 1) * pageSize);
            stmt.setInt(3, pageSize);
            ArrayList<Note> results = getNotes(stmt);
            conn.close();
            return results;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private ArrayList<Note> getNotes(PreparedStatement stmt) throws SQLException{
        ArrayList<Note> results = new ArrayList<Note>();
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            Note note = new Note(
                    rs.getInt("postId"),
                    rs.getInt("userId"),
                    rs.getString("content"),
                    rs.getDate("addTime"),
                    rs.getInt("locationId"),
                    rs.getInt("score"),
                    rs.getString("title")
            );
            results.add(note);
        }
        return results;
    }

    public Note getNoteByNoteId(int noteId) {
        String sql = "SELECT * FROM Note AS N, Post AS P WHERE N.postId = P.postId AND N.postId = ? ";
        Note note = null;
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, noteId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                note = new Note(
                        rs.getInt("postId"),
                        rs.getInt("userId"),
                        rs.getString("content"),
                        rs.getDate("addTime"),
                        rs.getInt("locationId"),
                        rs.getInt("score"),
                        rs.getString("title")
                );
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return note;
    }

    public ArrayList<Note> getFollowingNotes(int pageNumber, int pageSize, int userId) {
        String sql = "SELECT * FROM Note AS N, Post AS P WHERE N.postId = P.postId AND P.userId IN " +
                "(SELECT userId2 FROM Follow WHERE userId1 = ?) " +
                "ORDER BY addTime DESC LIMIT ? , ?";
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, (pageNumber - 1) * pageSize);
            stmt.setInt(3, pageSize);
            ArrayList<Note> results = getNotes(stmt);
            conn.close();
            return results;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateNote(int noteId, String content, String title, int grade) {
        updatePost(noteId, content);
        updateNote(noteId, title, grade);
    }

    private void updatePost(int noteId, String content) {
        String sql = "UPDATE Post SET content = ? WHERE postId = ?";
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, content);
            stmt.setInt(2, noteId);
            stmt.executeUpdate();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void updateNote(int noteId, String title, int grade) {
        String sql = "UPDATE Note SET score = ?, title = ? WHERE postId = ?";
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, grade);
            stmt.setString(2, title);
            stmt.setInt(3, noteId);
            stmt.executeUpdate();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<Note> searchNotes(int pageNumber, int pageSize, String keyword) {
        String sql = "SELECT * FROM Note AS N, Post AS P WHERE N.postId = P.postId AND " +
                "(N.title LIKE ? OR P.content LIKE ?) " +
                "ORDER BY addTime DESC LIMIT ? , ?";
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");
            stmt.setInt(3, (pageNumber - 1) * pageSize);
            stmt.setInt(4, pageSize);
            ArrayList<Note> results = getNotes(stmt);
            conn.close();
            return results;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
