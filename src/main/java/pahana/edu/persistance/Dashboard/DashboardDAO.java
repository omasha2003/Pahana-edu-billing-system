package pahana.edu.persistance.Dashboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import pahana.edu.persistance.dbconnection.DBConnection;

public class DashboardDAO {

    public int getTotalCustomers() {
        return getCount("SELECT COUNT(*) FROM customers");
    }

    public int getTotalItems() {
        return getCount("SELECT COUNT(*) FROM items");
    }

    public int getTotalUsers() {
        return getCount("SELECT COUNT(*) FROM users");
    }

    public int getTotalBills() {
        return getCount("SELECT COUNT(*) FROM bills");
    }

    public int getTodaysCustomers() {
        return getCount("SELECT COUNT(*) FROM customers WHERE DATE(last_updated) = CURDATE()");
    }

    private int getCount(String query) {
        int count = 0;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return count;
    }
}
