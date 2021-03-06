<%@ page import="neu.cs5200.otr.dao.NoteDAO" %>
<%@ page import="neu.cs5200.otr.entity.Note" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="neu.cs5200.otr.entity.Person" %>
<%@ page import="neu.cs5200.otr.dao.PersonDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: shunlin
  Date: 3/29/15
  Time: 16:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <p class="sndTitle">Latest Notes</p>
<%
    NoteDAO nd = new NoteDAO();
    int pageNumber = Integer.parseInt(request.getParameter("nnp"));
    ArrayList<Note> notes = nd.getLatestNotes(pageNumber, 5);
    String pageButtonURL = "pageButtons.jsp?pageNumber=" + pageNumber + "&tableName=Note&pageName=nnp";
    for (Note note : notes) {
        Person author = (new PersonDAO()).getPersonByUserId(note.getUserId());
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
    <jsp:include page="<%=pageButtonURL%>"/>
</div>
</body>
