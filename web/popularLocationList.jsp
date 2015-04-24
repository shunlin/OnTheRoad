<%@ page import="neu.cs5200.otr.dao.LocationDAO" %>
<%@ page import="neu.cs5200.otr.entity.Location" %>
<%@ page import="java.util.List" %>
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
<%
    LocationDAO ld = new LocationDAO();
    int pageNumber = Integer.parseInt(request.getParameter("plp"));
    List<Location> locations = ld.popularLocationList(pageNumber, 5);
    String pageButtonURL = "pageButtons.jsp?pageNumber=" + pageNumber + "&tableName=Location&pageName=plp";
%>
<div id="main">
    <p class="sndTitle">Popular Locations</p>
    <%
        for (Location location : locations) {
    %>
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
    <%
        }
    %>
    <jsp:include page="<%=pageButtonURL%>"/>
</div>
<jsp:include page="footer.jsp"/>
</body>
