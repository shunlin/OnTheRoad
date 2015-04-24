package neu.cs5200.otr.servlet;

import neu.cs5200.otr.dao.PersonDAO;
import neu.cs5200.otr.entity.Person;
import neu.cs5200.otr.util.CookieSetting;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

/**
 * Created by shunlin on 3/23/15.
 */
public class RegisterServlet extends MainServlet {
    private String username;
    private String password;
    private String event;
    private InputStream pic;
    PersonDAO pd = null;


    public RegisterServlet() {
        super();
        pd = new PersonDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        pic = null;
        username = "";
        password = "";
        event = "";
        parseFields(request);

        if (event.equals("register")) {
            processRegister(request, response);
            return;
        } else if (event.equals("edit")) {
            processEdit(request, response);
            return;
        } else {

        }

    }

    private void parseFields(HttpServletRequest request) {
        if(ServletFileUpload.isMultipartContent(request)) {
            try {
                List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
                for (FileItem item : items) {
                    if (item.isFormField()) {
                        if (item.getFieldName().equals("username")) username = item.getString();
                        if (item.getFieldName().equals("password")) password = item.getString();
                        if (item.getFieldName().equals("event")) event = item.getString();
                    } else {
                        pic = item.getInputStream();
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private void processRegister(HttpServletRequest request, HttpServletResponse response) {
        if (username.equals("") || password.equals("")) {
            fail(request, response, "Username / password cannot be empty", "fail.jsp");
            return;
        }

        Person person = new Person(username, password, false);
        int userId = pd.createPerson(person);
        if (userId == -1) {
            fail(request, response, "This username has already been used, please use another one.", "fail.jsp");
            return;
        }

        try {
            String path = getServletContext().getRealPath("") + File.separator + "user_picture" + File.separator + userId + ".jpg";
            FileUtils.copyInputStreamToFile(pic, new File(path));
        } catch (Exception e) {
            e.printStackTrace();
        }
        CookieSetting cs = new CookieSetting(request, response);
        cs.login(username, password);
        cs.rememberMe(userId);
        jumpTo(response, "index.jsp");
    }

    private void processEdit(HttpServletRequest request, HttpServletResponse response) {
        if (password.equals("")) {
            fail(request, response, "Username / password cannot be empty", "fail.jsp");
            return;
        }

        int userId = (Integer)request.getSession().getAttribute("userId");
        Person person = new Person(username, password, false);
        pd.update(userId, person);

        try {
            String path = getServletContext().getRealPath("") + File.separator + "user_picture" + File.separator + userId + ".jpg";
            File file = new File(path);
            if (file.exists()) file.delete();
            FileUtils.copyInputStreamToFile(pic, file);
        } catch (Exception e) {
            e.printStackTrace();
        }
        jumpTo(response, "index.jsp");
    }
}
