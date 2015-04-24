package neu.cs5200.otr.dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by shunlin on 3/29/15.
 */
public class UtilDAO extends DAO {
    public int getPageButtonNumber(String tableName) {
        String sql = "SELECT CEILING(COUNT(*) / 5) AS pages FROM " + tableName;
        int number = 0;
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                number = rs.getInt(1);
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return number;
    }
}
