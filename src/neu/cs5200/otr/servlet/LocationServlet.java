package neu.cs5200.otr.servlet;

import neu.cs5200.otr.dao.LocationDAO;
import neu.cs5200.otr.entity.Location;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import javax.servlet.ServletException;
import java.sql.Date;
import java.util.List;


/**
 * Created by shunlin on 3/25/15.
 */
public class LocationServlet extends MainServlet {
    LocationDAO ld = null;

    public LocationServlet() {
        super();
        ld = new LocationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        String type = request.getParameter("event");
        if (type == null) {
            jumpTo(response, "index.jsp");
            return;
        } else if (type.equals("delete")) {
            processDelete(request, response);
            return;
        } else {

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        String type = request.getParameter("event");
        if (type == null) {
            jumpTo(response, "index.jsp");
            return;
        } else if (type.equals("create")) {
            processCreate(request, response);
            return;
        } else if (type.equals("edit")) {
            processEdit(request, response);
            return;
        }
    }

    private void processDelete(HttpServletRequest request, HttpServletResponse response) {
        if (!isAdmin(request) || request.getParameter("locationId") == null) {
            fail(request, response, "Not enough auth", "index.jsp");
            return;
        }
        int locationId = Integer.parseInt(request.getParameter("locationId"));
        ld.deleteLocationByLocationId(locationId);
        jumpTo(response, "index.jsp");
    }

    private void processCreate(HttpServletRequest request, HttpServletResponse response) {
        String name = request.getParameter("name");
        String state = request.getParameter("state");
        String country = request.getParameter("country");
        String placeIntro = request.getParameter("placeIntro");
        Location location = new Location(name, state, country, placeIntro);
        int locationId = ld.createLocation(location);
        if (locationId != -1) {
            jumpTo(response, "location.jsp?locationId=" + locationId);
            return;
        } else {
            fail(request, response, "Cannot create new location", "fail.jsp");
            return;
        }
    }

    private void processEdit(HttpServletRequest request, HttpServletResponse response) {
        if (!isAdmin(request) || request.getParameter("locationId") == null) {
            fail(request, response, "Not enough auth", "index.jsp");
            return;
        }
        int locationId = Integer.parseInt(request.getParameter("locationId"));
        String name = request.getParameter("name");
        String state = request.getParameter("state");
        String country = request.getParameter("country");
        String placeIntro = request.getParameter("placeIntro");
        Location location = new Location(name, state, country, placeIntro);
        ld.update(locationId, location);
        jumpTo(response, "location.jsp?locationId=" + locationId);
    }
}
