<%@ page import="neu.cs5200.otr.util.CookieSetting" %>
<%@ page import="neu.cs5200.otr.entity.Person" %>
<%@ page import="neu.cs5200.otr.dao.PersonDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="neu.cs5200.otr.dao.NoteDAO" %>
<%@ page import="neu.cs5200.otr.entity.Note" %>
<%@ page import="neu.cs5200.otr.dao.LocationDAO" %>
<%@ page import="neu.cs5200.otr.entity.Location" %>
<%@ page import="java.util.ArrayList" %>
<%--
  Created by IntelliJ IDEA.
  User: shunlin
  Date: 3/23/15
  Time: 18:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    private PersonDAO pd = new PersonDAO();
    private CookieSetting cs;
    private LocationDAO ld = new LocationDAO();
    private NoteDAO nd = new NoteDAO();
%>
<%
    cs = new CookieSetting(request, response);
    cs.autoLogin();
    String keyword = request.getParameter("key");
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
        <%
            if (keyword == null || keyword == "") {
        %>
        <h4>Please input keyword</h4>
        <%
            } else {
        %>
        <h4>Search result of <%=keyword%>.</h4>

        <p class="sndTitle">Locations</p>
        <div class="marketing">
        <%
            List<Location> locations = ld.searchLocation(1, 100, keyword);
            for (Location location : locations) {
        %>
        <div class="row featurette">
            <div class="col-xs-4">
                <img class="featurette-image img-responsive center-block" src="picture/<%=location.getLocationId()%>.jpg"
                     alt="<%=location.getName()%>" width="500" height="500">
            </div>
            <div class="col-xs-8">
                <h3 class="featurette-heading"><%=location.getName()%>
                    <small><%=location.getState()%>, <%=location.getCountry()%></small></h3>
                <p class="lead"><%=location.getPlaceIntro()%>
                </p>
                <p><a class="btn btn-default" href="location.jsp?locationId=<%=location.getLocationId()%>">View details</a></p>
            </div>
        </div>
        <hr class="featurette-divider">
        <%
            }
        %>
        </div>

        <p class="sndTitle">Users</p>
        <div class="row">
            <%
                ArrayList<Person> users = pd.searchUser(keyword);
                for (Person user : users) {
            %>
            <div class="col-sm-1">
                <a class="fixed_a" href="user.jsp?uid=<%=user.getUserId()%>">
                    <img class="user_picture" src="user_picture/<%=user.getUserId()%>.jpg" alt="<%=user.getName()%>"/>
                </a>
                <p class="user"><a class="user" href="user.jsp?uid=<%=user.getUserId()%>"><%=user.getName()%></a></p>
            </div>
            <%
                }
            %>
        </div>

        <p class="sndTitle">Notes</p>
        <div class="marketing">
            <%
                ArrayList<Note> notes = nd.searchNotes(1, 100, keyword);
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
        <%}%>
    </div>
<jsp:include page="footer.jsp"/>
</body>
</html>