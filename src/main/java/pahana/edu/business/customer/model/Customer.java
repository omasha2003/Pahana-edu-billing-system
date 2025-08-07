package pahana.edu.business.customer.model;

public class Customer {
    private int id;
    private String accountNumber;
    private String customerName;
    private String address;
    private String telephone;
    private int unitsConsumed;
    private String registrationDate;
    private String createdBy;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getAccountNumber() { return accountNumber; }
    public void setAccountNumber(String accountNumber) { this.accountNumber = accountNumber; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getTelephone() { return telephone; }
    public void setTelephone(String telephone) { this.telephone = telephone; }

    public int getUnitsConsumed() { return unitsConsumed; }
    public void setUnitsConsumed(int unitsConsumed) { this.unitsConsumed = unitsConsumed; }

    public String getRegistrationDate() { return registrationDate; }
    public void setRegistrationDate(String registrationDate) { this.registrationDate = registrationDate; }

    public String getCreatedBy() { return createdBy; }
    public void setCreatedBy(String createdBy) { this.createdBy = createdBy; }
}
