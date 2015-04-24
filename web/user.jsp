<%@ page import="neu.cs5200.otr.util.CookieSetting" %>
<%@ page import="neu.cs5200.otr.entity.Person" %>
<%@ page import="java.io.IOException" %>
<%@ page import="neu.cs5200.otr.dao.PersonDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="neu.cs5200.otr.dao.NoteDAO" %>
<%@ page import="neu.cs5200.otr.entity.Note" %>
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
    private int viewerId;
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
    viewerId = cs.getViewerId();
    if (request.getParameter("uid") == null || request.getParameter("uid") == "") {
        fail(response);
        return;
    }
    int userId = Integer.parseInt(request.getParameter("uid"));
    user = pd.getPersonByUserId(userId);
    if (user == null) {
        fail(response);
        return;
    }
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
                    <img id="userPic" src="user_picture/<%=user.getUserId()%>.jpg" alt="<%=user.getName()%>" /></a>
            </div>
            <h3 class="title"><%=user.getName()%>'s Page</h3>
            <%
                if (!cs.checkLogin() || user.getUserId() == viewerId){

                } else if (pd.isFollowing(viewerId, user.getUserId())) {
            %>
            <a href="user.do?event=unFollow&uid=<%=user.getUserId()%>">UnFollow</a>
            <%  } else {
            %>
            <a href="user.do?event=follow&uid=<%=user.getUserId()%>">Follow</a>
            <%
                }
            %>
        </div>
        <div id="tvllist" class="marketing">
            <p class="sndTitle">Locations Like</p>
            <!--?php
                    $location = new Location();
                    $likes = $location->getLikeLocations($user->uid);
            for ($i = 0; $i < count($likes); ++$i)  {
            $location->showLocationBriefly($likes[$i]);
            }
            ?-->
        </div>

        <div id="friendlist" class="marketing">
            <p class="sndTitle">Following</p>
            <%
                ArrayList<Person> persons = pd.getFollowingList(user.getUserId());
                for (Person person : persons) {
            %>
            <div class="userBriefly">
                <div class="user_picture">
                    <a class="fixed_a" href="user.jsp?uid=<%=person.getUserId()%>">
                        <img class="user_picture" src="user_picture/<%=person.getUserId()%>.jpg" alt="<%=person.getName()%>" />
                    </a>
                    <p class="user"><a class="user" href="user.php?uid=<%=person.getUserId()%>"><%=person.getName()%></a></p>
                </div>
            </div>
            <%
                }
            %>
        </div>

        <div id="comment" class="marketing">
            <p class="sndTitle">Notes</p>
            <%
                NoteDAO nd = new NoteDAO();
                ArrayList<Note> notes = nd.getNotesByUserId(1, 10, user.getUserId());
                for (Note note : notes) {
                    Person author = pd.getPersonByUserId(note.getUserId());
            %>
            <div class="noteBriefly" class="marketing">
                <div class="user_picture">
                    <a class="fixed_a" href="user.jsp?uid=<%=note.getUserId()%>">
                        <img class="user_picture" src="user_picture/<%=note.getUserId()%>.jpg" alt="<%=author.getName()%>" />
                    </a>
                    <p class="user"><a class="user" href="user.jsp?uid=<%=note.getPostId()%>"><%=author.getName()%></a></p>
                </div>
                <h5><a href="note.jsp?noteId=<%=note.getPostId()%>"><%=note.getTitle()%>(<%=note.getScore()%>分)</a></h5>

                <p class="noteContent"><%=note.getContent()%></p>
                <p class="time">Post on<%=note.getAddTime()%></p>
            </div>
            <%
                }
            %>
        </div>
    </div>
    <jsp:include page="footer.jsp"/>
</body>
</html>

