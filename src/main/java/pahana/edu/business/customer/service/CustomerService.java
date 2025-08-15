package pahana.edu.business.customer.service;

import pahana.edu.business.customer.dto.CustomerDTO;
import pahana.edu.persistance.customer.dao.CustomerDAO;

import java.util.List;

public class CustomerService {
    private final CustomerDAO customerDAO = new CustomerDAO();

    public void addCustomer(CustomerDTO customerDTO) {
        customerDAO.addCustomer(customerDTO);
    }

    public void deleteCustomer(int id) {
        customerDAO.deleteCustomer(id);
    }

    public List<CustomerDTO> getAllCustomers() {
        return customerDAO.getAllCustomers();
    }

    public CustomerDTO getCustomerById(int id) {
        return customerDAO.getCustomerById(id);
    }

    public void updateCustomer(CustomerDTO customerDTO) {
        customerDAO.updateCustomer(customerDTO);
    }

    public List<CustomerDTO> searchByAccountOrName(String keyword) {
        return customerDAO.searchByAccountOrName(keyword);
    }
}
