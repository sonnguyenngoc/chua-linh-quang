class UserGroup < ActiveRecord::Base
    validates :name, presence: true, uniqueness: true
    
    def permissions
        permission.present? ? JSON.parse(permission) : {}
    end
    
    def ability(model, action)
        (permissions[model].present? and permissions[model][action].present?) ? permissions[model][action] : ['no']
    end
    
    def self.permission_classes
        [
            "Product",
            "Category", 
            "Manufacturer", 
            "Area", 
            "Article_category", 
            "Article", 
            "Code_status", 
            "Slideshow", 
            "Order", 
            "Delivery_method", 
            "Payment_method", 
            "Comment", 
            "Question", 
            "Comment_article", 
            "Testimonial", 
            "Voucher", 
            "Coupon", 
            "Customer", 
            "User", 
            "Company", 
            "Setting"
        ]
    end
end
