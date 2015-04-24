package neu.cs5200.otr.servlet;

import neu.cs5200.otr.dao.NoteDAO;
import neu.cs5200.otr.entity.Note;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by shunlin on 3/24/15.
 */
public class NoteServlet extends MainServlet {
    NoteDAO nd = null;

    public NoteServlet() {
        super();
        nd = new NoteDAO();
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
        else if (type.equals("edit")) {
            processEdit(request, response);
            return;
        }
        else {

        }
    }

    private void processDelete(HttpServletRequest request, HttpServletResponse response) {
        if (!isAdmin(request) || request.getParameter("noteId") == null) {
            fail(request, response, "Not enough auth", "index.jsp");
            return;
        }
        int noteId = Integer.parseInt(request.getParameter("noteId"));
        nd.deleteNoteByNoteId(noteId);
        jumpTo(response, "index.jsp");
    }

    private void processCreate(HttpServletRequest request, HttpServletResponse response) {
        int userId = (Integer)request.getSession().getAttribute("userId");
        String content = request.getParameter("content");
        int locationId  = Integer.parseInt(request.getParameter("locationId"));
        int grade = Integer.parseInt(request.getParameter("grade"));
        String title = request.getParameter("title");
        Note note = new Note(userId, content, locationId, grade, title);
        int noteId = nd.createNote(note);
        if (noteId != -1) {
            jumpTo(response, "location.jsp?locationId=" + locationId);
            return;
        } else {
            fail(request, response, "Cannot create new post", "fail.jsp");
            return;
        }
    }

    private void processEdit(HttpServletRequest request, HttpServletResponse response) {
        int noteId = Integer.parseInt(request.getParameter("noteId"));
        String content = request.getParameter("content");
        String title = request.getParameter("title");
        int grade = Integer.parseInt(request.getParameter("grade"));
        nd.updateNote(noteId, content, title, grade);
        jumpTo(response, "note.jsp?noteId=" + noteId);
    }
}
