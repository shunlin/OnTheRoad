<%@ page import="neu.cs5200.otr.util.CookieSetting" %>
<%@ page import="neu.cs5200.otr.dao.PersonDAO" %>
<%@ page import="neu.cs5200.otr.entity.Person" %>
<%@ page import="neu.cs5200.otr.entity.Location" %>
<%@ page import="neu.cs5200.otr.dao.LocationDAO" %>
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
    LocationDAO ld = new LocationDAO();
    int locationId = Integer.parseInt(request.getParameter("locationId"));
    Location location = ld.getLocationById(locationId);
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
        <form class="form-horizontal" action="editLocation.do" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="locationName" class="col-sm-4 control-label">Location Name</label>

                <div class="col-sm-8">
                    <input name="name" type="text" class="form-control" id="locationName" value="<%=location.getName()%>">
                </div>
            </div>
            <div class="form-group">
                <label for="locationState" class="col-sm-4 control-label" >Location State</label>

                <div class="col-sm-8">
                    <input name="state" type="text" class="form-control" id="locationState" value="<%=location.getState()%>">
                </div>
            </div>
            <div class="form-group">
                <label for="locationCountry" class="col-sm-4 control-label">Location Country</label>

                <div class="col-sm-8">
                    <input name="country" type="text" class="form-control" id="locationCountry" value="<%=location.getCountry()%>">
                </div>
            </div>
            <div class="form-group">
                <label for="locationDescription" class="col-sm-4 control-label">Location Description</label>

                <div class="col-sm-8">
                    <textarea name="placeIntro" class="form-control" rows="8" id="locationDescription"><%=location.getPlaceIntro()%></textarea>
                </div>
            </div>
            <div class="form-group">
                <label for="locationImage" class="col-sm-4 control-label">Location Image</label>
                <div class="col-sm-8">
                    <input type="file" name="locationPicture" id="locationImage"/>
                </div>
            </div>

            <div class="form-group">
                <div class="text-center vertical-middle-sm">
                    <input type="text" name="event" value="edit" style="display:none">
                    <input type="text" name="locationId" value="<%=location.getLocationId()%>" style="display: none"/>
                    <button type="submit" class="btn btn-default">Edit Location</button>
                </div>
            </div>

        </form>
    </div>
    <jsp:include page="footer.jsp"/>
</body>
</html>