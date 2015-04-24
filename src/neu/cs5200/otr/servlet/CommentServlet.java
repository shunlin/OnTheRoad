package neu.cs5200.otr.servlet;

import neu.cs5200.otr.dao.CommentDAO;
import neu.cs5200.otr.entity.Comment;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by shunlin on 3/25/15.
 */
public class CommentServlet extends MainServlet {
    CommentDAO cd = null;

    public CommentServlet() {
        super();
        cd = new CommentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        String type = request.getParameter("event");
        if (type == null) {
            jumpTo(response, "index.jsp");
            return;
        } else if (type.equals("delete")) {
            processDelete(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        String type = request.getParameter("event");
        if (type == null) {
            jumpTo(response, "index.jsp");
            return;
        }
        if (type.equals("create")) {
            processCreate(request, response);
            return;
        }
        else {

        }
    }

    private void processDelete(HttpServletRequest request, HttpServletResponse response) {
        if (!isAdmin(request) || request.getParameter("commentId") == null) {
            fail(request, response, "Not enough auth", "index.jsp");
            return;
        }
        int commentId = Integer.parseInt(request.getParameter("commentId"));
        Comment comment = cd.getCommentByCommentId(commentId);
        cd.deleteCommentByCommentId(commentId);
        jumpTo(response, "note.jsp?noteId=" + comment.getRelatedNoteId());
    }

    private void processCreate(HttpServletRequest request, HttpServletResponse response) {
        int userId = (Integer)request.getSession().getAttribute("userId");
        String content = request.getParameter("content");
        int postId = Integer.parseInt(request.getParameter("postId"));
        Comment comment = new Comment(userId, content, postId);
        int commentId = cd.createComment(comment);
        if (commentId != -1) {
            jumpTo(response, "note.jsp?noteId=" + postId);
            return;
        } else {
            fail(request, response, "Cannot create new comment", "fail.jsp");
            return;
        }

    }
}
