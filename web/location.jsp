<%@ page import="neu.cs5200.otr.entity.Location" %>
<%@ page import="neu.cs5200.otr.dao.LocationDAO" %>
<%@ page import="neu.cs5200.otr.util.CookieSetting" %>
<%@ page import="java.io.IOException" %>
<%@ page import="neu.cs5200.otr.dao.PersonDAO" %>
<%@ page import="neu.cs5200.otr.entity.Person" %>
<%@ page import="neu.cs5200.otr.entity.Note" %>
<%@ page import="java.util.List" %>
<%@ page import="neu.cs5200.otr.dao.NoteDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: shunlin
  Date: 3/24/15
  Time: 00:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    private Location location;
    private LocationDAO ld = new LocationDAO();
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
    if (request.getParameter("locationId") == null || request.getParameter("locationId") == "") {
        fail(response);
        return;
    }
    int locationId = Integer.parseInt(request.getParameter("locationId"));
    location = ld.getLocationById(locationId);
    if (location == null) {
        fail(response);
        return;
    }
    PersonDAO pd = new PersonDAO();
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
        <div id="tvlDetail">
            <p class="sndTitle"><%=location.getName()%></p>
            <%
                if (isAdmin) {
            %>
            <a href="location.do?event=delete&locationId=<%=location.getLocationId()%>" class="deleteButton">Delete</a>
            <a href="editLocation.jsp?locationId=<%=location.getLocationId()%>" class="deleteButton">Edit</a>
            <%
                }
            %>
            <div class="tvlpicture">
                <a class="fixed_a" href="location.jsp?locationId=<%=location.getLocationId()%>">
                    <img id="locationPicMid" src="picture/<%=location.getLocationId()%>.jpg" alt="<%=location.getName()%>" />
                </a>
                <%
                    if (!cs.checkLogin()){

                    } else if (!pd.isAlreadyLike(locationId, cs.getViewerId())) {
                %>
                <a href="user.do?event=like&uid=<%=viewer.getUserId()%>&locationId=<%=locationId%>">Like</a>
                <%  } else {
                %>
                <a href="user.do?event=unLike&uid=<%=viewer.getUserId()%>&locationId=<%=locationId%>">UnLike</a>
                <%
                    }
                %>
            </div>
            <p class="place">
                <span>State</span>： <%=location.getState()%>
            </p>
            <p class="country">
                <span>Country</span>： <%=location.getCountry()%>
            </p>
            <div class="sndTitle">Location Description</div>
            <p class="content"><%=location.getPlaceIntro()%></p>
        </div>
        <div id="note">
            <p class="sndTitle">Notes</p>
            <div class="table">
                <%
                    NoteDAO nd = new NoteDAO();
                    List<Note> notes = nd.getNotesByLocationId(1, 10, locationId);
                    for (Note note : notes) {
                        Person author = pd.getPersonByUserId(note.getUserId());
                %>
                <div class="row featurette">
                    <div class="col-xs-2">
                        <a class="fixed_a" href="user.jsp?uid=<%=note.getUserId()%>">
                            <img class="featurette-image img-responsive center-block" src="user_picture/<%=note.getUserId()%>.jpg"
                                 alt="<%=author.getName()%>" width="200" height="200">
                        </a>
                    </div>
                    <div class="col-xs-10">
                        <h4 class="featurette-heading"><a href="note.jsp?noteId=<%=note.getPostId()%>"><%=note.getTitle()%>
                            (<%=note.getScore()%> Points)</a></h4>

                        <p class="lead"><%=note.getContent()%>
                        </p>

                        <p>Post on <%=note.getAddTime()%>
                        </p>
                    </div>
                </div>
                <hr class="featurette-divider">
                <%
                    }

                %>
            </div>
            <%
                if (!cs.checkLogin()) {
            %>
            <a href="login.jsp">You can add new notes after login.</a>
            <%
                } else {
            %>
            <div id="addNote">
                <p class="sndTitle">Add a new note</p>
                <form class="form-horizontal" action="note.do" method="post">
                    <div class="form-group">
                        <label for="notetitle" class="col-sm-2 control-label">Note Title</label>
                        <div class="col-sm-9">
                            <input type="text" name="title" class="form-control" id="notetitle">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="notecontent" class="col-sm-2 control-label">Note Content</label>
                        <div class="col-sm-9">
                            <textarea name="content" rows="8" class="form-control" id="notecontent"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="grade" class="col-sm-2 control-label">Grade</label>
                        <div class="col-sm-9">
                            <input class="form-control" type="text" name="grade" maxlength="2" id="grade">
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="text-center vertical-middle-sm">
                            <input class="form-control" type="text" name="locationId" value="<%=location.getLocationId()%>" style="display:none" id="locationid" />
                            <input class="form-control" type="text" name="userId" value="<%=viewer.getUserId()%>" style="display:none" id="userid"/>
                            <input type="text" name="event" value="create" style="display:none" />
                            <button type="submit" class="btn btn-default">Post</button>
                        </div>
                    </div>
                </form>
            </div>
            <%
            }
            %>
        </div>
    </div>
    <jsp:include page="footer.jsp"/>
</body>
</html>