package pahana.edu.business.user.service;

import pahana.edu.business.user.dto.UserDTO;
import pahana.edu.business.user.mapper.UserMapper;
import pahana.edu.business.user.model.User;
import pahana.edu.persistance.user.dao.UserDAO;

import java.util.List;


public class UserService {
    private UserDAO userDAO = new UserDAO();

    public UserDTO login(String username, String password) {
        User user = userDAO.getUserByUsernameAndPassword(username, password);
        if (user != null) {
            return UserMapper.toDTO(user);
        }
        return null;
    }

    public List<UserDTO> getAllUsers() {
        return userDAO.getAllUsers();
    }



}


