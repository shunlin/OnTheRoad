package neu.cs5200.otr.servlet;

import neu.cs5200.otr.dao.PersonDAO;
import neu.cs5200.otr.util.CookieSetting;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Created by shunlin on 3/23/15.
 */
public class UserServlet extends MainServlet{
    PersonDAO pd = null;

    public UserServlet() {
        super();
        pd = new PersonDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        String type = request.getParameter("event");
        if (type == null) {
            jumpTo(response, "index.jsp");
            return;
        } else if (type.equals("logout")) {
            processLogout(request, response);
            return;
        } else if (type.equals("follow")) {
            follow(request, response);
            return;
        } else if (type.equals("unFollow")) {
            unFollow(request,response);
            return;
        } else if (type.equals("delete")) {
            processDelete(request, response);
            return;
        } else if (type.equals("like")) {
            processLike(request, response);
        } else if (type.equals("unLike")) {
            processUnLike(request, response);
        } else {

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        String type = request.getParameter("event");
        if (type == null) {
            jumpTo(response, "index.jsp");
            return;
        } else if (type.equals("login")) {
            processLogin(request, response);
            return;
        }
        else {

        }
    }

    private void processLogin(HttpServletRequest request, HttpServletResponse response) {
        if (!checkInput(request, response)) return;
        CookieSetting cs = new CookieSetting(request, response);
        int userId = cs.login(request.getParameter("username"), request.getParameter("password"));
        if (userId == -1) {
            fail(request, response, "Wrong username and password combination", "fail.jsp");
            return;
        }
        cs.rememberMe(userId);
        jumpTo(response, "index.jsp");
    }

    private boolean checkInput(HttpServletRequest request, HttpServletResponse response) {
        if (request.getParameter("username") == null || request.getParameter("username").equals("")) {
            fail(request, response, "No username", "fail.jsp");
            return false;
        }
        if (request.getParameter("password") == null || request.getParameter("password").equals("")) {
            fail(request, response, "No password", "fail.jsp");
            return false;
        }
        return true;
    }

    private void processLogout(HttpServletRequest request, HttpServletResponse response) {
        CookieSetting cs = new CookieSetting(request, response);
        cs.logout();
        jumpTo(response, "index.jsp");
     }

    private void follow(HttpServletRequest request, HttpServletResponse response) {
        if (request.getParameter("uid") == null) {
            fail(request, response, "fail", "user.jsp?uid=targetId");
            return;
        }
        int targetId = Integer.parseInt(request.getParameter("uid"));
        int userId = (Integer)request.getSession().getAttribute("userId");
        pd.follow(userId, targetId);
        jumpTo(response, "user.jsp?uid=" + targetId);
    }

    private void unFollow(HttpServletRequest request, HttpServletResponse response) {
        if (request.getParameter("uid") == null) {
            fail(request, response, "fail", "user.jsp?uid=targetId");
            return;
        }
        int targetId = Integer.parseInt(request.getParameter("uid"));
        int userId = (Integer)request.getSession().getAttribute("userId");
        pd.unFollow(userId, targetId);
        jumpTo(response, "user.jsp?uid=" + targetId);
    }

    private void processDelete(HttpServletRequest request, HttpServletResponse response) {
        if (!isAdmin(request) || request.getParameter("uid") == null) {
            fail(request, response, "Not enough auth", "index.jsp");
            return;
        }
        int userId = Integer.parseInt(request.getParameter("uid"));
        pd.deletePersonByUserId(userId);
        jumpTo(response, "admin.jsp");
    }

    private void processLike(HttpServletRequest request, HttpServletResponse response) {
        int locationId = Integer.parseInt(request.getParameter("locationId"));
        int userId = Integer.parseInt(request.getParameter("uid"));
        pd.likeLocation(locationId, userId);
        jumpTo(response, "location.jsp?locationId=" + locationId);

    }

    private void processUnLike(HttpServletRequest request, HttpServletResponse response) {
        int locationId = Integer.parseInt(request.getParameter("locationId"));
        int userId = Integer.parseInt(request.getParameter("uid"));
        pd.unLikeLocation(locationId, userId);
        jumpTo(response, "location.jsp?locationId=" + locationId);

    }
}
