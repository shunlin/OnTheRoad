<%--
  Created by IntelliJ IDEA.
  User: shunlin
  Date: 3/24/15
  Time: 00:19
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
    <form class="form-horizontal" action="register.do" method="post" enctype="multipart/form-data">
        <div class="text-center">
            <h3>Edit my account</h3>
        </div>
        <div class="form-group">
            <label for="newpassword" class="col-sm-4 control-label"> New Password:</label>
            <div class="col-sm-4">
                <input class="form-control" id="newpassword" type="password" name="password"/><br/><br/>
            </div>
        </div>
        <div class="form-group">
            <label for="uploadportrait" class="col-sm-4 control-label"> Upload Portrait:</label>
            <div class="col-sm-4">
                <input class="form-control" id="uploadportrait" type="file" name="userPicture"/>
            </div>
        </div>

        <div class="form-group">
            <div class="text-center vertical-middle-sm">
                <input type="text" name="event" value="edit" style="display:none">
                <button type="submit" class="btn btn-default">Edit</button>
            </div>
        </div>
    </form>
</div>
<jsp:include page="footer.jsp"/>
</body>
</html>
