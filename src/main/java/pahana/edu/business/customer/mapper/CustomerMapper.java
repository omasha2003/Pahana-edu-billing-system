package pahana.edu.business.customer.mapper;

import pahana.edu.business.customer.dto.CustomerDTO;
import pahana.edu.business.customer.model.Customer;
import java.time.format.DateTimeFormatter;

import java.sql.ResultSet;
import java.sql.SQLException;

public class CustomerMapper {
    public static CustomerDTO toDTO(Customer customer) {
        CustomerDTO dto = new CustomerDTO();
        dto.setId(customer.getId());
        dto.setAccountNumber(customer.getAccountNumber());
        dto.setCustomerName(customer.getCustomerName());
        dto.setAddress(customer.getAddress());
        dto.setTelephone(customer.getTelephone());
        dto.setUnitsConsumed(customer.getUnitsConsumed());
        dto.setRegistrationDate(customer.getRegistrationDate());
        dto.setCreatedBy(customer.getCreatedBy());
        return dto;
    }

    public static Customer toModel(CustomerDTO dto) {
        Customer customer = new Customer();
        customer.setId(dto.getId());
        customer.setAccountNumber(dto.getAccountNumber());
        customer.setCustomerName(dto.getCustomerName());
        customer.setAddress(dto.getAddress());
        customer.setTelephone(dto.getTelephone());
        customer.setUnitsConsumed(dto.getUnitsConsumed());
        customer.setRegistrationDate(dto.getRegistrationDate());
        customer.setCreatedBy(dto.getCreatedBy());
        return customer;
    }


    public static CustomerDTO map(ResultSet rs) throws SQLException {
        CustomerDTO dto = new CustomerDTO();
        dto.setId(rs.getInt("id"));
        dto.setAccountNumber(rs.getString("account_number"));
        dto.setCustomerName(rs.getString("customer_name"));
        dto.setAddress(rs.getString("address"));
        dto.setTelephone(rs.getString("telephone"));
        dto.setUnitsConsumed(rs.getInt("units_consumed"));

        // Convert LocalDateTime to String
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedDate = rs.getTimestamp("registration_date").toLocalDateTime().format(formatter);
        dto.setRegistrationDate(formattedDate);

        dto.setCreatedBy(rs.getString("created_by"));
        return dto;
    }

}
