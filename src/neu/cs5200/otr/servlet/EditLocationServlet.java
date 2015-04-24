package neu.cs5200.otr.servlet;

import neu.cs5200.otr.dao.LocationDAO;
import neu.cs5200.otr.entity.Location;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.InputStream;
import java.util.List;

/**
 * Created by shunlin on 3/28/15.
 */
public class EditLocationServlet extends MainServlet {
    private String name;
    private String state;
    private String country;
    private String placeIntro;
    private InputStream pic;
    private String event;
    private int locationId;
    LocationDAO ld = null;


    public EditLocationServlet() {
        super();
        ld = new LocationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        pic = null;
        name = "";
        state = "";
        country = "";
        placeIntro = "";
        event = "";
        locationId = -1;
        parseFields(request);
        if (name.equals("") || state.equals("") || country.equals("") || event.equals("")) {
            fail(request, response, "Name / state / country cannot be empty", "fail.jsp");
            return;
        }

        if (event.equals("create")) {
            processCreate(request, response);
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
                        if (item.getFieldName().equals("name")) name = item.getString();
                        if (item.getFieldName().equals("state")) state = item.getString();
                        if (item.getFieldName().equals("country")) country = item.getString();
                        if (item.getFieldName().equals("placeIntro")) placeIntro = item.getString();
                        if (item.getFieldName().equals("event")) event = item.getString();
                        if (item.getFieldName().equals("locationId")) locationId = Integer.parseInt(item.getString());
                    } else {
                        pic = item.getInputStream();
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private void processCreate(HttpServletRequest request, HttpServletResponse response) {
        Location location = new Location(name, state, country, placeIntro);
        int locationId = ld.createLocation(location);

        if (locationId == -1) {
            fail(request, response, "Create location failed", "fail.jsp");
            return;
        }

        try {
            String path = getServletContext().getRealPath("") + File.separator + "picture" + File.separator + locationId + ".jpg";
            FileUtils.copyInputStreamToFile(pic, new File(path));
        } catch (Exception e) {
            e.printStackTrace();
        }
        jumpTo(response, "location.jsp?locationId=" + locationId);
    }

    private void processEdit(HttpServletRequest request, HttpServletResponse response) {
        if (locationId == -1) {
            fail(request, response, "Edit location failed", "fail.jsp");
            return;
        }

        Location location = new Location(name, state, country, placeIntro);

        ld.update(locationId, location);


        try {
            String path = getServletContext().getRealPath("") + File.separator + "picture" + File.separator + locationId + ".jpg";
            File file = new File(path);
            if (file.exists()) file.delete();
            FileUtils.copyInputStreamToFile(pic, file);
        } catch (Exception e) {
            e.printStackTrace();
        }
        jumpTo(response, "location.jsp?locationId=" + locationId);
    }


}
