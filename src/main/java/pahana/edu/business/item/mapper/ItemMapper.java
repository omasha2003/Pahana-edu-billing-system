package pahana.edu.business.item.mapper;

import pahana.edu.business.item.dto.ItemDTO;
import pahana.edu.business.item.model.Item;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ItemMapper {

    public static ItemDTO toDTO(Item item) {
        ItemDTO dto = new ItemDTO();
        dto.setId(item.getId());
        dto.setTitle(item.getTitle());
        dto.setAuthor(item.getAuthor());
        dto.setPrice(item.getPrice());
        dto.setQuantity(item.getQuantity());
        dto.setCategory(item.getCategory());
        dto.setLanguage(item.getLanguage());
        dto.setAddedBy(item.getAddedBy());
        dto.setAddedDate(item.getAddedDate());
        return dto;
    }

    public static Item toModel(ItemDTO dto) {
        Item item = new Item();
        item.setId(dto.getId());
        item.setTitle(dto.getTitle());
        item.setAuthor(dto.getAuthor());
        item.setPrice(dto.getPrice());
        item.setQuantity(dto.getQuantity());
        item.setCategory(dto.getCategory());
        item.setLanguage(dto.getLanguage());
        item.setAddedBy(dto.getAddedBy());
        item.setAddedDate(dto.getAddedDate());
        return item;
    }

    // ✅ This is what you're missing:
    public static ItemDTO map(ResultSet rs) throws SQLException {
        ItemDTO dto = new ItemDTO();
        dto.setId(rs.getInt("id"));
        dto.setTitle(rs.getString("title"));
        dto.setAuthor(rs.getString("author"));
        dto.setPrice(rs.getDouble("price"));
        dto.setQuantity(rs.getInt("quantity"));
        dto.setCategory(rs.getString("category"));
        dto.setLanguage(rs.getString("language"));
        dto.setAddedBy(rs.getString("added_by"));
        dto.setAddedDate(rs.getString("added_date"));
        return dto;
    }
}
