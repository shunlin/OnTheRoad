<%@ page import="neu.cs5200.otr.util.CookieSetting" %>
<%@ page import="neu.cs5200.otr.entity.Note" %>
<%@ page import="neu.cs5200.otr.dao.NoteDAO" %>
<%@ page import="java.io.IOException" %>
<%@ page import="neu.cs5200.otr.dao.PersonDAO" %>
<%@ page import="neu.cs5200.otr.entity.Person" %>
<%--
  Created by IntelliJ IDEA.
  User: shunlin
  Date: 3/24/15
  Time: 00:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    private Note note;
    private NoteDAO nd = new NoteDAO();
    private CookieSetting cs;

    private void fail(HttpServletRequest request, HttpServletResponse response, String message, String url) {
        request.getSession().setAttribute("message", message);
        try {
            response.sendRedirect(url);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
%>
<%
    cs = new CookieSetting(request, response);
    cs.autoLogin();
    if (request.getParameter("noteId") == null || request.getParameter("noteId") == "") {
        fail(request, response, "Wrong note id", "fail.jsp");
        return;
    }
    int noteId = Integer.parseInt(request.getParameter("noteId"));
    note = nd.getNoteByNoteId(noteId);
    if (note == null) {
        fail(request, response, "Wrong note id", "fail.jsp");
        return;
    }
    if (note.getUserId() != cs.getViewerId()) {
        fail(request, response, "No authority", "fail.jsp");
        return;
    }
    PersonDAO pd = new PersonDAO();
    Person author = pd.getPersonByUserId(note.getUserId());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>OnTheRoad</title>
    <link href="css/travelogue.css" rel="stylesheet" type="text/css"/>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<jsp:include page="header.jsp"/>
<div id="main">
    <div class="row">
        <div class="col-sm-1">
            <a href="user.jsp?uid=<%=note.getUserId()%>">
                <img class="user_picture" src="user_picture/<%=note.getUserId()%>.jpg" alt="<%=author.getName()%>"/>
            </a>

            <p class="user"><a class="user" href="user.jsp?uid=<%=note.getUserId()%>"><%=author.getName()%>
            </a></p>
        </div>
        <div class="col-sm-11">
            <form class="form-horizontal" action="note.do" method="post">
                <div class="form-group">
                    <label for="notetitle" class="col-sm-2 control-label">Note Title</label>

                    <div class="col-sm-9">
                        <input name="title" type="text" class="form-control" id="notetitle"
                               value="<%=note.getTitle()%>">
                    </div>
                </div>
                <div class="form-group">
                    <label for="notecontent" class="col-sm-2 control-label">Note Content</label>

                    <div class="col-sm-9">
                        <textarea name="content" type="text" rows="8" class="form-control" id="notecontent"><%=note.getContent()%></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputgrad" class="col-sm-2 control-label">Grade</label>

                    <div class="col-sm-9">
                        <input name="grade" type="text" class="form-control" maxlength="2" id="inputgrad"
                               value="<%=note.getScore()%>">
                    </div>
                </div>

                <div class="form-group">
                    <div class="text-center vertical-middle-sm">
                        <input type="text" name="noteId" value="<%=note.getPostId()%>" style="display:none">
                        <input type="text" name="event" value="edit" style="display:none"/>
                        <button type="submit" class="btn btn-default">Edit Note</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>
</body>
</html>
