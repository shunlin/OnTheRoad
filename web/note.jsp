<%@ page import="neu.cs5200.otr.util.CookieSetting" %>
<%@ page import="neu.cs5200.otr.entity.Note" %>
<%@ page import="neu.cs5200.otr.dao.NoteDAO" %>
<%@ page import="java.io.IOException" %>
<%@ page import="neu.cs5200.otr.dao.PersonDAO" %>
<%@ page import="neu.cs5200.otr.entity.Person" %>
<%@ page import="neu.cs5200.otr.dao.CommentDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="neu.cs5200.otr.entity.Comment" %>
<%@ page import="neu.cs5200.otr.dao.LocationDAO" %>
<%@ page import="neu.cs5200.otr.entity.Location" %>
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
    private void fail(HttpServletResponse response) {
        try {
            response.sendRedirect("fail.jsp");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
%>
<%
    cs = new CookieSetting(request, response);
    cs.autoLogin();
    if (request.getParameter("noteId") == null || request.getParameter("noteId") == "") {
        fail(response);
        return;
    }
    int noteId = Integer.parseInt(request.getParameter("noteId"));
    note = nd.getNoteByNoteId(noteId);
    if (note == null) {
        fail(response);
        return;
    }
    PersonDAO pd = new PersonDAO();
    Person author = pd.getPersonByUserId(note.getUserId());
    Person viewer = pd.getPersonByUserId(cs.getViewerId());
    boolean isAdmin = false;
    if (viewer != null && viewer.isAdmin()) isAdmin = viewer.isAdmin();
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
        <div class="noteDetail">
            <div class="user_picture">
                <a class="fixed_a" href="user.jsp?uid=<%=note.getUserId()%>">
                    <img class="user_picture" src="user_picture/<%=note.getUserId()%>.jpg" alt="<%=author.getName()%>" />
                </a>
                <p class="user"><a class="user" href="user.jsp?uid=<%=note.getUserId()%>"><%=author.getName()%></a></p>
                <%
                    if (cs.getViewerId() == note.getUserId()) {
                %>
                <a href="editNote.jsp?noteId=<%=note.getPostId()%>">Edit Post</a>
                <%
                    }
                %>
            </div>
            <h3><a href="note.jsp?noteId=<%=note.getPostId()%>"><%=note.getTitle()%>(<%=note.getScore()%> Points)</a></h3>
            <%
                if (isAdmin) {
            %>
            <a href="note.do?event=delete&noteId=<%=note.getPostId()%>" class="deleteButton">Delete</a>
            <%
                }
            %>
            <p class="noteContent lead"><%=note.getContent()%></p>
            <p class="time">Post on <%=note.getAddTime()%></p>
        </div>
        <%
            LocationDAO ld = new LocationDAO();
            Location location = ld.getLocationById(note.getLocationId());
        %>
        <p class="sndTitle">Related Location</p>
        <div class="row featurette">
            <div class="col-xs-4">
                <img class="featurette-image img-responsive center-block" src="picture/<%=location.getLocationId()%>.jpg"
                     alt="<%=location.getName()%>" width="400" height="400">
            </div>
            <div class="col-xs-8">
                <h3 class="featurette-heading"><%=location.getName()%>
                    <small><%=location.getState()%>, <%=location.getCountry()%>
                    </small>
                </h3>
                <p class="lead"><%=location.getPlaceIntro()%>
                </p>

                <p><a class="btn btn-default" href="location.jsp?locationId=<%=location.getLocationId()%>">View details</a>
                </p>
            </div>
        </div>
        <hr class="featurette-divider">

        <div class="comments">
            <p class="sndTitle">Comments</p>
            <%
                CommentDAO cd = new CommentDAO();
                ArrayList<Comment> comments = cd.getCommentsByNoteId(1, 100, note.getPostId());
                for (Comment comment : comments) {
                    Person commentAuthor = pd.getPersonByUserId(comment.getUserId());

            %>
            <div class="row featurette">
                <div class="col-xs-2">
                    <a class="fixed_a" href="user.jsp?uid=<%=comment.getUserId()%>">
                        <img class="featurette-image img-responsive center-block" src="user_picture/<%=comment.getUserId()%>.jpg" width="200" height="200">
                    </a>
                </div>
                <div class="col-xs-10">
                    <p class="lead"><%=comment.getContent()%></p>
                    <p>Post on <%=comment.getAddTime()%></p>
                </div>
                <%
                    if (isAdmin) {
                %>
                <a href="comment.do?event=delete&commentId=<%=comment.getPostId()%>" class="deleteButton">Delete</a>
                <%
                    }
                %>
            </div>
            <hr class="featurette-divider">
            <%
                }
            %>
        </div>
        <%
            if (cs.checkLogin()) {
        %>
        <form class="form-horizontal" action="comment.do" method="post">
            <div class="form-group">
                <label for="comment" class="col-sm-2 control-label">Comment</label>
                <div class="col-sm-9">
                    <textarea name="content" rows="8" class="form-control" id="comment"></textarea>
                </div>
            </div>

            <div class="form-group">
                <div class="text-center vertical-middle-sm">
                    <input type="text" name="postId" value="<%=note.getPostId()%>" style="display:none" />
                    <input type="text" name="event" value="create" style="display:none" />
                    <button type="submit" class="btn btn-default">Submit Comment</button>
                </div>
            </div>
        </form>
        <%
            }
            else {
        %>
        <a href="login.jsp">You can add comment after login</a>
        <%
            }
        %>
    </div>
    <jsp:include page="footer.jsp"/>
</body>
</html>
