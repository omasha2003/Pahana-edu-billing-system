package pahana.edu.persistance.item.dao;

import pahana.edu.business.item.dto.ItemDTO;
import pahana.edu.business.item.mapper.ItemMapper;
import pahana.edu.business.item.service.ItemService;
import pahana.edu.persistance.dbconnection.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ItemDAO {

    public void addItem(ItemDTO item) {
        String sql = "INSERT INTO items (title, author, price, quantity, category, language, added_by) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, item.getTitle());
            stmt.setString(2, item.getAuthor());
            stmt.setDouble(3, item.getPrice());
            stmt.setInt(4, item.getQuantity());
            stmt.setString(5, item.getCategory());
            stmt.setString(6, item.getLanguage());
            stmt.setString(7, item.getAddedBy());
            stmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public List<ItemDTO> getAllItems() {
        List<ItemDTO> items = new ArrayList<>();
        String sql = "SELECT * FROM items";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ItemDTO item = ItemMapper.map(rs);
                System.out.println("DEBUG: Loaded item: " + item.getTitle());
                items.add(item);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return items;
    }


    public void deleteItem(int id) {
        String sql = "DELETE FROM items WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public ItemDTO getItemById(int id) {
        String sql = "SELECT * FROM items WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return ItemMapper.map(rs);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateItem(ItemDTO item) {
        String sql = "UPDATE items SET title=?, author=?, price=?, quantity=?, category=?, language=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, item.getTitle());
            stmt.setString(2, item.getAuthor());
            stmt.setDouble(3, item.getPrice());
            stmt.setInt(4, item.getQuantity());
            stmt.setString(5, item.getCategory());
            stmt.setString(6, item.getLanguage());
            stmt.setInt(7, item.getId());
            stmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public List<ItemDTO> searchByTitleOrAuthor(String keyword) {
        List<ItemDTO> items = new ArrayList<>();

        String sql = "SELECT * FROM items WHERE title LIKE ? OR author LIKE ? OR category LIKE ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                ItemDTO item = new ItemDTO();
                item.setId(rs.getInt("id"));
                item.setTitle(rs.getString("title"));
                item.setAuthor(rs.getString("author"));
                item.setPrice(rs.getDouble("price"));
                item.setQuantity(rs.getInt("quantity"));
                item.setCategory(rs.getString("category"));
                item.setLanguage(rs.getString("language"));
                item.setAddedBy(rs.getString("added_by"));
                item.setAddedDate(rs.getString("added_date"));
                items.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return items;
    }



    public Map<String, String> findItem(String bookSearch) {
        Map<String, String> item = null;
        String sql = "SELECT * FROM items WHERE id = ? OR title LIKE ? LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, bookSearch);
            stmt.setString(2, "%" + bookSearch + "%");
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                item = new HashMap<>();
                item.put("id", rs.getString("id"));
                item.put("title", rs.getString("title"));
                item.put("author", rs.getString("author"));
                item.put("price", rs.getString("price"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return item;
    }

}
