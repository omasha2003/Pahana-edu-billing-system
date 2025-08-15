package pahana.edu.business.billing.model;

import java.util.List;

public class Bill {
    private int id;
    private String billNo;
    private int customerId;
    private String cashierName;
    private double totalAmount;
    private String paymentMethod;
    private String billDate;
    private List<BillItem> items;

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getBillNo() {
        return billNo;
    }
    public void setBillNo(String billNo) {
        this.billNo = billNo;
    }

    public int getCustomerId() {
        return customerId;
    }
    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getCashierName() {
        return cashierName;
    }
    public void setCashierName(String cashierName) {
        this.cashierName = cashierName;
    }

    public double getTotalAmount() {
        return totalAmount;
    }
    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }
    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getBillDate() {
        return billDate;
    }
    public void setBillDate(String billDate) {
        this.billDate = billDate;
    }

    public List<BillItem> getItems() {
        return items;
    }
    public void setItems(List<BillItem> items) {
        this.items = items;
    }
}
