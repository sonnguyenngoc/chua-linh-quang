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
            {
                class_name: "Product",
                display_name: I18n.t(:product),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "create", values: ["yes","no"], multiple: false},
                            {name: "update", values: ["yes","no","own","not_own","approved","not_approved"], multiple: true},
                            {name: "delete", values: ["yes","no","own","not_own","approved","not_approved"], multiple: true},
                            {name: "approve", values: ["yes","no","own","not_own"], multiple: true}
                        ]
            },
            {
                class_name: "Category",
                display_name: I18n.t(:category),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "create", values: ["yes","no"], multiple: false},
                            {name: "update", values: ["yes","no"], multiple: false},
                            {name: "delete", values: ["yes","no"], multiple: false},
                        ]
            },
            {
                class_name: "Manufacturer",
                display_name: I18n.t(:manufacturer),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "create", values: ["yes","no"], multiple: false},
                            {name: "update", values: ["yes","no"], multiple: false},
                            {name: "delete", values: ["yes","no"], multiple: false},
                        ]
            },
            {
                class_name: "Area",
                display_name: I18n.t(:area),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "create", values: ["yes","no"], multiple: false},
                            {name: "update", values: ["yes","no"], multiple: false},
                            {name: "delete", values: ["yes","no"], multiple: false},
                        ]
            },
            {
                class_name: "ArticleCategory",
                display_name: I18n.t(:article_category),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "create", values: ["yes","no"], multiple: false},
                            {name: "update", values: ["yes","no"], multiple: false},
                            {name: "delete", values: ["yes","no"], multiple: false},
                        ]
            },
            {
                class_name: "Article",
                display_name: I18n.t(:article),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "create", values: ["yes","no"], multiple: false},
                            {name: "update", values: ["yes","no","own","not_own", "not_approved"], multiple: true},
                            {name: "delete", values: ["yes","no","own","not_own", "not_approved"], multiple: true},
                        ]
            },
            {
                class_name: "CodeStatus",
                display_name: I18n.t(:code_status),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "create", values: ["yes","no"], multiple: false},
                            {name: "update", values: ["yes","no"], multiple: false},
                            {name: "delete", values: ["yes","no"], multiple: false},
                        ]
            },
            {
                class_name: "Slideshow",
                display_name: I18n.t(:slideshow),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "create", values: ["yes","no"], multiple: false},
                            {name: "update", values: ["yes","no"], multiple: false},
                            {name: "delete", values: ["yes","no"], multiple: false},
                        ]
            },
            {
                class_name: "Order",
                display_name: I18n.t(:order),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "update", values: ["yes","no"], multiple: false},
                            {name: "delete", values: ["yes","no"], multiple: false},
                        ]
            },
            {
                class_name: "DeliveryMethod",
                display_name: I18n.t(:delivery_method),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "create", values: ["yes","no"], multiple: false},
                            {name: "update", values: ["yes","no"], multiple: false},
                            {name: "delete", values: ["yes","no"], multiple: false},
                        ]
            },
            {
                class_name: "PaymentMethod",
                display_name: I18n.t(:payment_method),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "create", values: ["yes","no"], multiple: false},
                            {name: "update", values: ["yes","no"], multiple: false},
                            {name: "delete", values: ["yes","no"], multiple: false},
                        ]
            },
            {
                class_name: "Comment",
                display_name: I18n.t(:comment),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "delete", values: ["yes","no"], multiple: false},
                        ]
            },
            {
                class_name: "Question",
                display_name: I18n.t(:question),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "delete", values: ["yes","no","own","not_own"], multiple: true},
                        ]
            },
            {
                class_name: "Testimonial",
                display_name: I18n.t(:tertimonial),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "delete", values: ["yes","no","own","not_own"], multiple: true},
                        ]
            },
            {
                class_name: "CommentArticle",
                display_name: I18n.t(:comment_article),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "delete", values: ["yes","no"], multiple: false},
                        ]
            },
            {
                class_name: "Voucher",
                display_name: I18n.t(:voucher),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "create", values: ["yes","no"], multiple: false},
                            {name: "update", values: ["yes","no"], multiple: false},
                            {name: "delete", values: ["yes","no"], multiple: false},
                        ]
            },
            {
                class_name: "Coupon",
                display_name: I18n.t(:coupon),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "create", values: ["yes","no"], multiple: false},
                            {name: "update", values: ["yes","no"], multiple: false},
                            {name: "delete", values: ["yes","no"], multiple: false},
                        ]
            },
            {
                class_name: "Customer",
                display_name: I18n.t(:customer),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "create", values: ["yes","no"], multiple: false},
                            {name: "update", values: ["yes","no"], multiple: false},
                            {name: "delete", values: ["yes","no"], multiple: false},
                        ]
            },
            {
                class_name: "Contact",
                display_name: I18n.t(:contact),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "delete", values: ["yes","no"], multiple: false},
                        ]
            },
            {
                class_name: "Newsletter",
                display_name: I18n.t(:newsletter),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "delete", values: ["yes","no"], multiple: false},
                        ]
            },
            {
                class_name: "User",
                display_name: I18n.t(:user),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "create", values: ["yes","no"], multiple: false},
                            {name: "update", values: ["yes","no"], multiple: false},
                            {name: "delete", values: ["yes","no"], multiple: false},
                        ]
            },
            {
                class_name: "UserGroup",
                display_name: I18n.t(:user_group),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "create", values: ["yes","no"], multiple: false},
                            {name: "update", values: ["yes","no"], multiple: false},
                            {name: "delete", values: ["yes","no"], multiple: false},
                        ]
            },
            {
                class_name: "Company",
                display_name: I18n.t(:company),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "create", values: ["yes","no"], multiple: false},
                            {name: "update", values: ["yes","no"], multiple: false},
                            {name: "delete", values: ["yes","no"], multiple: false},
                        ]
            },
            {
                class_name: "Setting",
                display_name: I18n.t(:system_setting),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "create", values: ["yes","no"], multiple: false},
                            {name: "update", values: ["yes","no"], multiple: false},
                            {name: "delete", values: ["yes","no"], multiple: false},
                        ]
            }
        ]
    end
end
