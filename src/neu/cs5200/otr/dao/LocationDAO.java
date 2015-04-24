package neu.cs5200.otr.dao;

import java.sql.*;

import neu.cs5200.otr.entity.Location;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by shunlin on 3/21/15.
 */
public class LocationDAO extends DAO{
	public Location getLocationById(int locationId){
        String sql = "SELECT * FROM Location WHERE locationId = ? LIMIT 1";
        Location l = null;
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, locationId);
            ResultSet results = stmt.executeQuery();
            if (results.next()) {
                l = new Location(
                        results.getInt("locationId"),
                        results.getString("name"),
                        results.getString("state"),
                        results.getString("country"),
                        results.getString("placeIntro"),
                        results.getDate("addTime")
                        );
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return l;
	}

	public int getLocationIdByName(String name) {
		int locationId = -1;
		String sql = "SELECT locationId FROM Location WHERE name = ?";
		try {
            Connection conn = ds.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, name);
			ResultSet results = stmt.executeQuery();
			if (results.next()) {
				locationId = results.getInt("locationId");
				return locationId;
			}
            conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return locationId;
	}

	public int createLocation(Location l) {
		//if (existLocation(l.getName()))
		//	return -1;

		String sql = "INSERT INTO Location(name, state, country, placeIntro, addTime) VALUES (?, ?, ?, ?,?)";
        int locationId = -1;
		try {
            Connection conn = ds.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, l.getName());
			stmt.setString(2, l.getState());
			stmt.setString(3, l.getCountry());
			stmt.setString(4, l.getPlaceIntro());
			stmt.setDate(5, l.getAddTime());
			stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) locationId = rs.getInt(1);
            conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return locationId;
	}

	public List<Location> selectAll() {
		List<Location> locations = new ArrayList<Location>();
		String sql = "SELECT * FROM Location";

		try {
            Connection connection = ds.getConnection();
			PreparedStatement statement = connection.prepareStatement(sql);
			ResultSet results = statement.executeQuery();
			while (results.next()) {
				Location location = new Location(results.getInt("locationId"),
						results.getString("name"), results.getString("state"),
						results.getString("country"),
						results.getString("placeIntro"),
						results.getDate("addTime"));
				locations.add(location);
			}
            connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return locations;
	}

	public void update(int id, Location entity) {
		String sql = "UPDATE Location SET name = ?, state = ?, country = ?, placeIntro = ? WHERE locationId = ?";

		try {
            Connection conn = ds.getConnection();
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setString(1, entity.getName());
			statement.setString(2, entity.getState());
			statement.setString(3, entity.getCountry());
			statement.setString(4, entity.getPlaceIntro());
			statement.setInt(5, id);
			statement.execute();
            conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public ArrayList<Location> getLikeLocations(int userId) {
        ArrayList<Location> locations = new ArrayList<Location>();
		String sql = "SELECT b.locationId AS locationId, b.name AS name, b.state AS state, b.country AS country, left(b.placeIntro,100) AS placeIntro, b.addTime AS addTime " +
                "FROM `Like` AS l, Location b WHERE l.userId = ? AND b.locationId = l.locationId";

		try {
            Connection connection = ds.getConnection();
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1,userId);
			ResultSet results = statement.executeQuery();
			while (results.next()) {
				Location location = new Location(results.getInt("locationId"),
						results.getString("name"), results.getString("state"),
						results.getString("country"),
						results.getString("placeIntro"),
						results.getDate("addTime"));
				locations.add(location);
			}
            connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return locations;
	}

	public List<Location> newLocationList(int pageNum, int pageSize) {
		List<Location> locations = new ArrayList<Location>();
		String sql = "SELECT locationId, name, state, country, placeIntro, addTime FROM Location " +
                "ORDER BY addTime DESC LIMIT ?, ?";

		try {
            Connection connection = ds.getConnection();
			PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, (pageNum - 1) * pageSize);
            statement.setInt(2, pageSize);
			ResultSet results = statement.executeQuery();
			while (results.next()) {
				Location location = new Location(
                        results.getInt("locationId"),
						results.getString("name"),
                        results.getString("state"),
						results.getString("country"),
						results.getString("placeIntro"),
						results.getDate("addTime"));
				locations.add(location);
			}
            connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return locations;
	}

	public List<Location> popularLocationList(int pageNum, int pageSize)  {
		List<Location> locations = new ArrayList<Location>();
		String sql = "SELECT b.locationId AS locationId, b.name AS name, b.state AS state, b.country AS country, left(b.placeIntro, 100) " +
                "AS placeIntro, b.addTime AS addTime, count(b.locationId) AS hotRate " +
                "FROM Location AS b LEFT JOIN `Like` AS l ON b.locationId = l.locationId GROUP BY b.locationId ORDER BY hotRate DESC LIMIT ?, ?";

		try {
            Connection connection = ds.getConnection();
			PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, (pageNum - 1) * pageSize);
            statement.setInt(2, pageSize);
			ResultSet results = statement.executeQuery();
			while (results.next()) {
				Location location = new Location(
                        results.getInt("locationId"),
						results.getString("name"),
                        results.getString("state"),
						results.getString("country"),
						results.getString("placeIntro"),
						results.getDate("addTime"));
				locations.add(location);
			}
            connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return locations;
	}

	public boolean deleteLocationByLocationId(int locationId){
		String sql = "DELETE FROM Location where locationId = ?";

		try {
            Connection connection = ds.getConnection();
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setInt(1,locationId);
			statement.execute();
            connection.close();
			return true;
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

    public List<Location> searchLocation(int pageNum, int pageSize, String keyword) {
        List<Location> locations = new ArrayList<Location>();
        String sql = "SELECT locationId, name, state, country, placeIntro, addTime FROM Location " +
                "WHERE name LIKE ? LIMIT ?, ?";

        try {
            Connection connection = ds.getConnection();
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(2, (pageNum - 1) * pageSize);
            statement.setInt(3, pageSize);
            statement.setString(1, '%' + keyword + '%');
            ResultSet results = statement.executeQuery();
            while (results.next()) {
                Location location = new Location(
                        results.getInt("locationId"),
                        results.getString("name"),
                        results.getString("state"),
                        results.getString("country"),
                        results.getString("placeIntro"),
                        results.getDate("addTime"));
                locations.add(location);
            }
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return locations;
    }

	public boolean existLocation(String name) {
		return getLocationIdByName(name) != -1;
	}
}
