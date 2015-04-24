<%@ page import="neu.cs5200.otr.util.CookieSetting" %>
<%@ page import="neu.cs5200.otr.entity.Person" %>
<%@ page import="neu.cs5200.otr.dao.PersonDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="neu.cs5200.otr.dao.NoteDAO" %>
<%@ page import="neu.cs5200.otr.entity.Note" %>
<%@ page import="neu.cs5200.otr.entity.Location" %>
<%@ page import="neu.cs5200.otr.dao.LocationDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: shunlin
  Date: 3/23/15
  Time: 18:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    private Person user;
    private PersonDAO pd = new PersonDAO();
    private CookieSetting cs;
%>
<%
    cs = new CookieSetting(request, response);
    if (cs.getViewerId() == -1) {
        response.sendRedirect("login.jsp");
        return;
    }
    cs.autoLogin();
    user = pd.getPersonByUserId(cs.getViewerId());
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
    <div id="myInfo" class="marketing">
        <div class="userPicture">
            <a class="fixed_a" href="user.jsp?uid=<%=user.getUserId()%>">
                <img id="userPic" src="user_picture/<%=user.getUserId()%>.jpg" alt="<%=user.getName()%>"/></a>
        </div>
        <h3 class="title"><%=user.getName()%>'s Page</h3>
    </div>
    <div id="tvllist" class="marketing">
        <p class="sndTitle">Scene I like</p>
        <%
            LocationDAO ld = new LocationDAO();
            ArrayList<Location> locations = ld.getLikeLocations(user.getUserId());
            for (Location location : locations) {
        %>
        <div class="row featurette">
            <div class="col-xs-4">
                <img class="featurette-image img-responsive center-block" src="picture/<%=location.getLocationId()%>.jpg"
                     alt="<%=location.getName()%>" width="500" height="500">
            </div>
            <div class="col-xs-7">
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

    <div id="friendlist" class="marketing">
        <p class="sndTitle">My Following</p>
        <%
            ArrayList<Person> persons = pd.getFollowingList(user.getUserId());
            for (Person person : persons) {
        %>
        <hr class="featurette-divider">
        <div class="row featurette">
            <div class="col-xs-2 text-center">
                <a class="fixed_a" href="user.jsp?uid=<%=person.getUserId()%>">
                    <img class="featurette-image img-responsive center-block" src="user_picture/<%=person.getUserId()%>.jpg"
                         alt="<%=person.getName()%>" width="200" height="200">
                </a>
                <p><a href="user.jsp?uid=<%=person.getUserId()%>"><%=person.getName()%></a></p>
            </div>
            <div class="col-xs-10">
        </div>
        <%
            }
        %>
    </div>

    <div id="comment" class="marketing">
        <p class="sndTitle">My Notes</p>
        <%
            NoteDAO nd = new NoteDAO();
            ArrayList<Note> notes = nd.getNotesByUserId(1, 10, user.getUserId());
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
</div>
<jsp:include page="footer.jsp"/>
</body>
</html>