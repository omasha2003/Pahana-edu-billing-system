package pahana.edu.persistance.bill.dao;

import pahana.edu.business.billing.dto.BillDTO;
import pahana.edu.business.billing.dto.BillItemDTO;
import pahana.edu.business.billing.mapper.BillMapper;
import pahana.edu.persistance.dbconnection.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {

    public int saveBill(BillDTO bill) throws SQLException {
        String sql = "INSERT INTO bills (bill_no, customer_id, cashier_name, total_amount, payment_method) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, bill.getBillNo());
            ps.setInt(2, bill.getCustomerId());
            ps.setString(3, bill.getCashierName());
            ps.setDouble(4, bill.getTotalAmount());
            ps.setString(5, bill.getPaymentMethod());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found", e);
        }
        return 0;
    }

    public void saveBillItems(List<BillItemDTO> items) throws SQLException {
        String sql = "INSERT INTO bill_items (bill_id, item_id, quantity, price, subtotal) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            for (BillItemDTO item : items) {
                ps.setInt(1, item.getBillId());
                ps.setInt(2, item.getItemId());
                ps.setInt(3, item.getQuantity());
                ps.setDouble(4, item.getPrice());
                ps.setDouble(5, item.getSubtotal());
                ps.addBatch();
            }
            ps.executeBatch();
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found", e);
        }
    }

    public List<BillDTO> getAllBills() {
        List<BillDTO> bills = new ArrayList<>();
        String sql = "SELECT * FROM bills";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                bills.add(BillMapper.map(rs));
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return bills;
    }

    public BillDTO getBillById(int id) {
        String sql = "SELECT * FROM bills WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return BillMapper.map(rs);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void deleteBill(int id) {
        String sql = "DELETE FROM bills WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
