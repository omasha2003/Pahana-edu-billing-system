package pahana.edu.persistance.customer.dao;

import pahana.edu.business.customer.dto.CustomerDTO;
import pahana.edu.business.customer.mapper.CustomerMapper;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static pahana.edu.persistance.dbconnection.DBConnection.getConnection;

public class CustomerDAO {

    public void addCustomer(CustomerDTO customer) {
        String sql = "INSERT INTO customers (account_number, customer_name, address, telephone, units_consumed, created_by) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, customer.getAccountNumber());
            stmt.setString(2, customer.getCustomerName());
            stmt.setString(3, customer.getAddress());
            stmt.setString(4, customer.getTelephone());
            stmt.setInt(5, customer.getUnitsConsumed());
            stmt.setString(6, customer.getCreatedBy());

            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<CustomerDTO> getAllCustomers() {
        List<CustomerDTO> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                customers.add(CustomerMapper.map(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return customers;
    }

    public void deleteCustomer(int id) {
        String sql = "DELETE FROM customers WHERE id=?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public CustomerDTO getCustomerById(int id) {
        String sql = "SELECT * FROM customers WHERE id=?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return CustomerMapper.map(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateCustomer(CustomerDTO customer) {
        String sql = "UPDATE customers SET account_number=?, customer_name=?, address=?, telephone=?, units_consumed=? WHERE id=?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, customer.getAccountNumber());
            stmt.setString(2, customer.getCustomerName());
            stmt.setString(3, customer.getAddress());
            stmt.setString(4, customer.getTelephone());
            stmt.setInt(5, customer.getUnitsConsumed());
            stmt.setInt(6, customer.getId());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<CustomerDTO> searchByAccountOrName(String keyword) {
        List<CustomerDTO> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers WHERE account_number LIKE ? OR customer_name LIKE ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            String pattern = "%" + keyword + "%";
            stmt.setString(1, pattern);
            stmt.setString(2, pattern);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                customers.add(CustomerMapper.map(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return customers;
    }

    public Map<String, String> findCustomer(String accountNumber, String telephone) {
        Map<String, String> customer = null;
        String sql = "SELECT * FROM customers WHERE account_number = ? OR telephone = ? LIMIT 1";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, accountNumber);
            stmt.setString(2, telephone);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                customer = new HashMap<>();
                customer.put("id", rs.getString("id"));
                customer.put("customer_name", rs.getString("customer_name"));
                customer.put("address", rs.getString("address"));
                customer.put("telephone", rs.getString("telephone"));
                customer.put("account_number", rs.getString("account_number"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return customer;
    }
}
