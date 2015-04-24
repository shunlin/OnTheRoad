package neu.cs5200.otr.servlet;

import neu.cs5200.otr.dao.PersonDAO;
import neu.cs5200.otr.entity.Person;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by shunlin on 3/25/15.
 */
public abstract class MainServlet extends HttpServlet {

    protected void jumpTo(HttpServletResponse response, String url) {
        try {
            response.sendRedirect(url);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    protected void fail(HttpServletRequest request, HttpServletResponse response, String message, String url) {
        request.getSession().setAttribute("message", message);
        try {
            response.sendRedirect(url);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    protected boolean isAdmin(HttpServletRequest request) {
        PersonDAO pd = new PersonDAO();
        Person person =  pd.getPersonByUserId((Integer)request.getSession().getAttribute("userId"));
        return person.isAdmin();
    }
}
