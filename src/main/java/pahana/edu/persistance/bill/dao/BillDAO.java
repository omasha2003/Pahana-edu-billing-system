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

    public List<BillDTO> findBillsWithItemsByCustomerId(int customerId) throws ClassNotFoundException {
        List<BillDTO> bills = new ArrayList<>();
        String sqlBills = "SELECT * FROM bills WHERE customer_id = ? ORDER BY bill_date DESC";
        String sqlItems = "SELECT bi.id, bi.bill_id, bi.item_id, i.title AS item_title, bi.quantity, bi.price, bi.subtotal " +
                "FROM bill_items bi JOIN items i ON bi.item_id = i.id WHERE bi.bill_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement psBills = conn.prepareStatement(sqlBills);
             PreparedStatement psItems = conn.prepareStatement(sqlItems)) {

            psBills.setInt(1, customerId);
            try (ResultSet rsBills = psBills.executeQuery()) {
                while (rsBills.next()) {
                    BillDTO bill = new BillDTO();
                    bill.setId(rsBills.getInt("id"));
                    bill.setBillNo(rsBills.getString("bill_no"));
                    bill.setBillDate(rsBills.getString("bill_date"));

                    // Fetch items for this bill
                    List<BillItemDTO> items = new ArrayList<>();
                    psItems.setInt(1, bill.getId());
                    try (ResultSet rsItems = psItems.executeQuery()) {
                        while (rsItems.next()) {
                            BillItemDTO item = new BillItemDTO();
                            item.setId(rsItems.getInt("id"));
                            item.setBillId(rsItems.getInt("bill_id"));
                            item.setItemId(rsItems.getInt("item_id"));
                            item.setItemTitle(rsItems.getString("item_title"));
                            item.setQuantity(rsItems.getInt("quantity"));
                            item.setPrice(rsItems.getDouble("price"));
                            item.setSubtotal(rsItems.getDouble("subtotal"));
                            items.add(item);
                        }
                    }
                    bill.setItems(items);
                    bills.add(bill);
                }
            }
        } catch (SQLException e) {
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
