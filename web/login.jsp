<%--
  Created by IntelliJ IDEA.
  User: shunlin
  Date: 3/22/15
  Time: 23:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Login -- On The Road</title>
    <link href="css/travelogue.css" rel="stylesheet" type="text/css"/>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="container">
    <div class="login"><a href="index.jsp"><img class="login" alt="On The Road" src="pics/header.jpg"/></a></div>
    <div class="row col-sm-offset-4">
        <div class="col-sm-4">
            <h3 class="form-signin-heading">Please sign in</h3>
        </div>
    </div>
    <div class="row col-sm-offset-4">
        <div class="col-sm-8">
            <form class="form-horizontal" action="user.do" method="post">
                <div class="form-group">
                    <label for="username" class="col-sm-2 control-label">Username</label>
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
                    <div class="col-sm-offset-2 col-sm-4">
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" value="remember-me"> Remember me
                            </label>
                        </div>
                    </div>
                </div>
                <div class="col-sm-8 text-center vertical-middle-sm">
                    <input type="text" name="event" value="login" style="display: none"/>
                    <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
                    <p><a href="register.jsp">Register</a></p>
                    <p><a href="index.jsp">Return</a></p>
                </div>
            </form>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>
</body>
</html>
