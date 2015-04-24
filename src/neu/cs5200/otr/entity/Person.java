package neu.cs5200.otr.entity;

/**
 * Created by shunlin on 3/21/15.
 */
public class Person {
    private int userId;
    private String name;
    private String password;
    private boolean isAdmin;

    public Person(String name, String password, boolean isAdmin) {
        this.userId = -1;
        this.name = name;
        this.password = password;
        this.isAdmin = isAdmin;
    }

    public Person(int userId, String name, String password, boolean isAdmin) {
        this.userId = userId;
        this.name = name;
        this.password = password;
        this.isAdmin = isAdmin;
    }

    public int getUserId() {
        return this.userId;
    }

    public String getName() {
        return this.name;
    }

    public String getPassword() {
        return this.password;
    }

    public boolean isAdmin() {
        return this.isAdmin;
    }
}
