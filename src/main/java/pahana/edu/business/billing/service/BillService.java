package pahana.edu.business.billing.service;

import pahana.edu.business.billing.dto.BillDTO;
import pahana.edu.business.billing.dto.BillItemDTO;
import pahana.edu.persistance.bill.dao.BillDAO;

public class BillService {
    private final BillDAO billDAO = new BillDAO();

    public int createBill(BillDTO bill) throws Exception {
        int billId = billDAO.saveBill(bill);
        for (BillItemDTO item : bill.getItems()) {
            item.setBillId(billId);
        }
        billDAO.saveBillItems(bill.getItems());
        return billId;
    }
}
