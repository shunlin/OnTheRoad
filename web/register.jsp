<%--
  Created by IntelliJ IDEA.
  User: shunlin
  Date: 3/22/15
  Time: 23:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN" class="ua-windows ua-webkit">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link href="css/travelogue.css" rel="stylesheet" type="text/css">
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
</head>
<body>
    <div class="login">
        <a href="index.jsp">
            <img class="login" alt="On The Road" src="pics/header.jpg">
        </a>
    </div>
    <div class="row col-sm-offset-4">
        <form class="form-signin form-horizontal" action="register.do" method="post" enctype="multipart/form-data">
            <div class="col-sm-8">
                <div class="form-group">
                    <label for="username" class="col-sm-2 control-label">User Name</label>
                    <div class="col-sm-6">
                        <input type="text" id="username" name="username" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword" class="col-sm-2 control-label">Password</label>
                    <div class="col-sm-6">
                    <input type="password" id="inputPassword" name="password" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label for="uploadphoto" class="col-sm-2 control-label">Photo</label>
                    <div class="col-sm-6">
                    <input type="file" name="userPicture" id="uploadphoto"/>
                    </div>
                </div>
                <div class="form-group">
                    <input type="text" name="event" value="register" style="display:none">
                    <div class="col-sm-8">
                    <button class="btn btn-lg btn-primary btn-block" type="submit">Register</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <jsp:include page="footer.jsp"/>
</body>
</html>
