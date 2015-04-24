<%@ page import="neu.cs5200.otr.entity.Person" %>
<%@ page import="neu.cs5200.otr.util.CookieSetting" %>
<%@ page import="neu.cs5200.otr.dao.PersonDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: shunlin
  Date: 3/22/15
  Time: 22:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    CookieSetting cs = new CookieSetting(request, response);
    PersonDAO pd = new PersonDAO();
    if (cs.checkLogin() == true) {
        int userId = cs.getViewerId();
        Person viewer = pd.getPersonByUserId(userId);
if (viewer.isAdmin()) {

%>
    <li><a href="admin.jsp">Admin</a></li>
        <%      }
%>
    <li><a href="editAccount.jsp">My Account</a></li>
    <li><a href="user.do?event=logout">Log Out</a></li>
        <%  } else  {
%>
    <li><a href="login.jsp">Log In</a></li>
    <li><a href="register.jsp">Register</a></li>
<% }
%>