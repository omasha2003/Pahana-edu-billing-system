package pahana.edu.business.item.service;

import pahana.edu.business.item.dto.ItemDTO;
import pahana.edu.persistance.item.dao.ItemDAO;

import java.util.List;

public class ItemService {
    private final ItemDAO itemDAO = new ItemDAO();

    public void addItem(ItemDTO item) {
        itemDAO.addItem(item);
    }

    public void deleteItem(int id) {
        itemDAO.deleteItem(id);
    }

    public List<ItemDTO> getAllItems() {
        return itemDAO.getAllItems();
    }

    public ItemDTO getItemById(int id) {
        return itemDAO.getItemById(id);
    }

    public void updateItem(ItemDTO item) {
        itemDAO.updateItem(item);
    }
}
