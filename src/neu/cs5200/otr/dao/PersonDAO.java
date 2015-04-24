package neu.cs5200.otr.dao;

import neu.cs5200.otr.entity.Person;

import java.sql.*;
import java.util.ArrayList;

/**
 * Created by shunlin on 3/21/15.
 */
public class PersonDAO extends DAO {

    public int createPerson(Person p) {
        if (existPerson(p.getName())) return -1;
        String sql = "INSERT INTO Person(username, password, auth) VALUES(?, ?, ?)";
        int userId = -1;
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, p.getName());
            stmt.setString(2, p.getPassword());
            stmt.setInt(3, p.isAdmin() ? 1 : 0);
            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) userId = rs.getInt(1);
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userId;
    }

    public boolean existPerson(String name) {
        return getPersonIdByName(name) != -1;
    }

    public int getPersonIdByName(String name) {
        int userId = -1;
        String sql = "SELECT userId FROM Person WHERE username = ?";
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            ResultSet results = stmt.executeQuery();
            if (results.next()) {
                userId = results.getInt("userId");
                conn.close();
                return userId;
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userId;
    }

    public Person getPersonByUserId(int userId) {
        String sql = "SELECT * FROM Person WHERE userId = ? LIMIT 1";
        Person person = null;
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            ResultSet results = stmt.executeQuery();
            if (results.next()) {
                person = new Person(
                        results.getInt("userId"),
                        results.getString("username"),
                        results.getString("password"),
                        results.getInt("auth") == 1
                        );
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return person;
    }

    public Person getPersonByUsername(String username) {
        String sql = "SELECT * FROM Person WHERE username = ? LIMIT 1";
        Person person = null;
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            ResultSet results = stmt.executeQuery();
            if (results.next()) {
                person = new Person(
                        results.getInt("userId"),
                        results.getString("username"),
                        results.getString("password"),
                        results.getInt("auth") == 1
                );
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return person;
    }

    public Person getPersonByUsernameAndPassword(String username, String password) {
        String sql = "SELECT * FROM Person WHERE username = ? AND password = ? LIMIT 1";
        Person person = null;
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet results = stmt.executeQuery();
            if (results.next()) {
                person = new Person(
                        results.getInt("userId"),
                        results.getString("username"),
                        results.getString("password"),
                        results.getInt("auth") == 1
                );
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return person;
    }


    public boolean deletePersonByUserId(int userId) {
        String sql = "DELETE FROM Person WHERE userId = ?";
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.executeUpdate();
            conn.close();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isFollowing(int userId, int followId) {
        String sql = "SELECT * FROM Follow WHERE userId1 = ? AND userId2 = ? LIMIT 1";
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, followId);
            ResultSet results = stmt.executeQuery();
            if (results.next()) {
                conn.close();
                return true;
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean follow(int userId, int followId) {
        String sql = "INSERT INTO Follow VALUES(?, ?)";
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, followId);
            stmt.executeUpdate();
            conn.close();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean unFollow(int userId, int followId) {
        String sql = "DELETE FROM Follow WHERE userId1 = ? AND userId2 = ?";
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, followId);
            stmt.executeUpdate();
            conn.close();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public ArrayList<Person> getFollowingList(int userId) {
        String sql = "SELECT userId2 FROM Follow WHERE userId1 = ?";
        ArrayList<Person> result = new ArrayList<Person>();
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            ResultSet results = stmt.executeQuery();
            while (results.next()) {
                Person person = this.getPersonByUserId(results.getInt("userId2"));
                result.add(person);
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public boolean isAlreadyLike(int locationId, int userId) {
        String sql = "SELECT * FROM `Like` WHERE locationId = ? AND userId = ?";
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, locationId);
            stmt.setInt(2, userId);
            ResultSet results = stmt.executeQuery();
            if (results.next()) return true;
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean likeLocation(int locationId, int userId) {
        String sql = "INSERT INTO `Like` VALUES(?, ?)";
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, locationId);
            stmt.setInt(2, userId);
            stmt.executeUpdate();
            conn.close();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean unLikeLocation(int locationId, int userId) {
        String sql = "DELETE FROM `Like` WHERE locationId = ? AND userId = ?";
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, locationId);
            stmt.setInt(2, userId);
            stmt.executeUpdate();
            conn.close();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public ArrayList<Person> getAllUsers() {
        String sql = "SELECT userId FROM Person WHERE auth = 0";
        ArrayList<Person> result = new ArrayList<Person>();
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet results = stmt.executeQuery();
            while (results.next()) {
                Person person = this.getPersonByUserId(results.getInt("userId"));
                result.add(person);
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public void update(int userId, Person person) {
        String sql = "UPDATE Person SET password = ? WHERE userId = ?";
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, person.getPassword());
            stmt.setInt(2, userId);
            stmt.executeUpdate();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<Person> searchUser(String keyword) {
        String sql = "SELECT userId FROM Person WHERE username LIKE ?";
        ArrayList<Person> result = new ArrayList<Person>();
        try {
            Connection conn = ds.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + keyword + "%");
            ResultSet results = stmt.executeQuery();
            while (results.next()) {
                Person person = this.getPersonByUserId(results.getInt("userId"));
                result.add(person);
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public static void main (String[] args) {
        PersonDAO pd = new PersonDAO();
        Person p = new Person("efg", "123456", true);
        System.out.println(pd.createPerson(p));
        Person p2 = pd.getPersonByUserId(7);
        System.out.println(p2.getName());
    }
}
