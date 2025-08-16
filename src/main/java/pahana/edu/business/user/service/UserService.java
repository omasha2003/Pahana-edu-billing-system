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

    public UserDTO getUserById(int id) {
        User user = userDAO.getUserById(id); // returns User
        if (user != null) {
            return UserMapper.toDTO(user); // convert to DTO
        }
        return null;
    }


    public void updateUser(UserDTO userDTO) {
        User user = UserMapper.toModel(userDTO);
        userDAO.updateUser(user);
    }


    public void deleteUser(int id) {
        userDAO.deleteUser(id);
    }

}




