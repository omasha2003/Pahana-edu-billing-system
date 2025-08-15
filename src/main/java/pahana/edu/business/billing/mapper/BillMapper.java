package pahana.edu.business.billing.mapper;

import pahana.edu.business.billing.dto.BillDTO;
import pahana.edu.business.billing.model.Bill;
import pahana.edu.business.billing.dto.BillItemDTO;
import pahana.edu.business.billing.model.BillItem;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.stream.Collectors;

public class BillMapper {

    public static BillDTO toDTO(Bill bill) {
        BillDTO dto = new BillDTO();
        dto.setId(bill.getId());
        dto.setBillNo(bill.getBillNo());
        dto.setCustomerId(bill.getCustomerId());
        dto.setCashierName(bill.getCashierName());
        dto.setTotalAmount(bill.getTotalAmount());
        dto.setPaymentMethod(bill.getPaymentMethod());
        dto.setBillDate(bill.getBillDate());
        dto.setItems(bill.getItems().stream().map(BillMapper::toItemDTO).collect(Collectors.toList()));
        return dto;
    }

    public static Bill toModel(BillDTO dto) {
        Bill bill = new Bill();
        bill.setId(dto.getId());
        bill.setBillNo(dto.getBillNo());
        bill.setCustomerId(dto.getCustomerId());
        bill.setCashierName(dto.getCashierName());
        bill.setTotalAmount(dto.getTotalAmount());
        bill.setPaymentMethod(dto.getPaymentMethod());
        bill.setBillDate(dto.getBillDate());
        bill.setItems(dto.getItems().stream().map(BillMapper::toItemModel).collect(Collectors.toList()));
        return bill;
    }

    public static BillItemDTO toItemDTO(BillItem item) {
        BillItemDTO dto = new BillItemDTO();
        dto.setId(item.getId());
        dto.setBillId(item.getBillId());
        dto.setItemId(item.getItemId());
        dto.setItemTitle(item.getItemTitle());
        dto.setQuantity(item.getQuantity());
        dto.setPrice(item.getPrice());
        dto.setSubtotal(item.getSubtotal());
        return dto;
    }

    public static BillItem toItemModel(BillItemDTO dto) {
        BillItem item = new BillItem();
        item.setId(dto.getId());
        item.setBillId(dto.getBillId());
        item.setItemId(dto.getItemId());
        item.setItemTitle(dto.getItemTitle());
        item.setQuantity(dto.getQuantity());
        item.setPrice(dto.getPrice());
        item.setSubtotal(dto.getSubtotal());
        return item;
    }

    public static BillDTO map(ResultSet rs) throws SQLException {
        BillDTO dto = new BillDTO();
        dto.setId(rs.getInt("id"));
        dto.setBillNo(rs.getString("bill_no"));
        dto.setCustomerId(rs.getInt("customer_id"));
        dto.setCashierName(rs.getString("cashier_name"));
        dto.setTotalAmount(rs.getDouble("total_amount"));
        dto.setPaymentMethod(rs.getString("payment_method"));
        dto.setBillDate(rs.getString("bill_date"));


        return dto;
    }
}
