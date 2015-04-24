package neu.cs5200.otr.dao;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Created by shunlin on 3/21/15.
 */
public class DAO {
    protected DataSource ds;
    public DAO() {
        try {
            Context ctx = new InitialContext();
            ds = (DataSource)ctx.lookup("java:comp/env/jdbc/OnTheRoad");
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }
}
