<%@ page import="neu.cs5200.otr.util.CookieSetting" %>
<%--
  Created by IntelliJ IDEA.
  User: shunlin
  Date: 3/20/15
  Time: 23:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    public String newLocationPageNumber = "1";
    public String popularLocationPageNumber = "1";
    public String newNotePageNumber = "1";
%>
<%
    CookieSetting cs = new CookieSetting(request, response);
    cs.autoLogin();

    if (request.getParameter("nlp") != null) newLocationPageNumber = request.getParameter("nlp");
    if (request.getParameter("plp") != null) popularLocationPageNumber = request.getParameter("plp");
    if (request.getParameter("nnp") != null) newNotePageNumber = request.getParameter("nnp");

    String newLocationURL = "newLocationList.jsp?nlp=" + newLocationPageNumber;
    String hotLocationURL = "popularLocationList.jsp?plp=" + popularLocationPageNumber;
    String newNoteURL = "newNoteList.jsp?nnp=" + newNotePageNumber;
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
    <div class="container" id="indexMainBlock">
        <!-- Three columns of text below the carousel -->
        <div class="row">
            <div class="col-lg-4">
                <img class="img-circle center" src="picture/LastLocation.jpg" alt="Generic placeholder image" width="300" height="300">
                <h3>Latest Locations</h3>
                <p>LastLocation You have been</p>
                <p><a class="btn btn-default" href="<%=newLocationURL%>" role="button">View details »</a></p>
            </div><!-- /.col-lg-4 -->
            <div class="col-lg-4">
                <img class="img-circle" src="picture/HotLocation.jpg" alt="Generic placeholder image" width="300" height="300" align="middle">
                <h3>Popular Locations</h3>
                <p>Most Popular Location</p>
                <p><a class="btn btn-default" href="<%=hotLocationURL%>" role="button">View details »</a></p>
            </div><!-- /.col-lg-4 -->
            <div class="col-lg-4">
                <img class="img-circle" src="picture/note.jpg" alt="Generic placeholder image" width="300" height="300">
                <h3>Latest Notes</h3>
                <p>Travelism Notes</p>
                <p><a class="btn btn-default" href="<%=newNoteURL%>" role="button">View details »</a></p>
            </div><!-- /.col-lg-4 -->
        </div><!-- /.row -->
    </div>
    <jsp:include page="footer.jsp"/>
</body>
</html>
