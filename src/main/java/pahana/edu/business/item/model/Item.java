package pahana.edu.business.item.model;

public class Item {
    private int id;
    private String title;
    private String author;
    private double price;
    private int quantity;
    private String category;
    private String language;
    private String addedBy;
    private String addedDate;

    // Getters
    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getAuthor() {
        return author;
    }

    public double getPrice() {
        return price;
    }

    public int getQuantity() {
        return quantity;
    }

    public String getCategory() {
        return category;
    }

    public String getLanguage() {
        return language;
    }

    public String getAddedBy() {
        return addedBy;
    }

    public String getAddedDate() {
        return addedDate;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public void setAddedBy(String addedBy) {
        this.addedBy = addedBy;
    }

    public void setAddedDate(String addedDate) {
        this.addedDate = addedDate;
    }
}
