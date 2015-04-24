<%@ page import="neu.cs5200.otr.dao.UtilDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: shunlin
  Date: 3/29/15
  Time: 17:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="pages">
<%
    int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
    String tableName = request.getParameter("tableName");
    String pageName = request.getParameter("pageName");
    String url = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getRequestURI();
    UtilDAO ud = new UtilDAO();
    int totalPages = ud.getPageButtonNumber(tableName);
    for (int i = 0; i < totalPages; i++) {
        int num = i + 1;
        if (num == pageNumber) {
        %>
        <span class="current"><%=num%></span>
        <%
        } else {
        %>
        <span><a href="<%=url%>?<%=pageName%>=<%=num%>"><%=num%></a></span>
        <%
        }
    }
%>
</div>


