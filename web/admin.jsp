<%@ page import="neu.cs5200.otr.util.CookieSetting" %>
<%@ page import="neu.cs5200.otr.dao.PersonDAO" %>
<%@ page import="neu.cs5200.otr.entity.Person" %>
<%@ page import="java.util.ArrayList" %>
<%--
  Created by IntelliJ IDEA.
  User: shunlin
  Date: 3/24/15
  Time: 00:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    CookieSetting cs = new CookieSetting(request, response);
    cs.autoLogin();
    PersonDAO pd = new PersonDAO();
    Person viewer = pd.getPersonByUserId(cs.getViewerId());
    if (viewer == null || !viewer.isAdmin()) {
        response.sendRedirect("index.jsp");
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
    <h3>All registered users</h3>
    <div class="row">
    <%
        ArrayList<Person> users = pd.getAllUsers();
        for (Person user : users) {
    %>

        <div class="col-sm-1">
            <a class="fixed_a" href="user.jsp?uid=<%=user.getUserId()%>">
                <img class="user_picture" src="user_picture/<%=user.getUserId()%>.jpg" alt="<%=user.getName()%>"/>
            </a>
            <p class="user"><a class="user" href="user.jsp?uid=<%=user.getUserId()%>"><%=user.getName()%></a></p>
            <p class="user"><a class="user" href="user.do?event=delete&uid=<%=user.getUserId()%>">delete</a></p>
        </div>

    <%
        }
    %>
    </div>
    <hr class="featurette-divider">
    <div class="addLocationBlock">
        <a href="addLocation.jsp"><h3>Add new location</h3></a>
    </div>
</div>
<jsp:include page="footer.jsp"/>
</body>
</html>