<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar navbar-inverse" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <a class="fixed_a" href="index.jsp"><img id="logo" src="pics/header.jpg"/></a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-left">
                <li><a href="myPage.jsp">My Page</a></li>
                <li><a href="myFollowing.jsp">My Following</a></li>
                <li><a href="myNotes.jsp">My Notes</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-center">
                <form class="navbar-form" action="search.jsp" method="get">
                    <div class="form-group">
                        <input class="searchKey form-control" type="text" name="key"/>
                    </div>
                    <button type="submit" class="btn btn-success">Search Scene/User/Note</button>
                </form>
            </ul>
            <ul id="control" class="nav navbar-nav navbar-right">
                <jsp:include page="userBar.jsp"/>
            </ul>
        </div>
        <!--/.nav-collapse -->
    </div>
</nav>