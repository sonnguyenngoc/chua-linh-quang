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
                            {name: "approve", values: ["yes","no","own","not_own"], multiple: true},
                        ]
            },         
            {
                class_name: "Gallery",
                display_name: I18n.t(:gallery),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "create", values: ["yes","no"], multiple: false},
                            {name: "update", values: ["yes","no"], multiple: false},
                            {name: "delete", values: ["yes","no"], multiple: false},
                        ]
            },
            {
                class_name: "Album",
                display_name: I18n.t(:album),
                actions: [
                            {name: "read", values: ["yes","no"], multiple: false},
                            {name: "create", values: ["yes","no"], multiple: false},
                            {name: "update", values: ["yes","no"], multiple: false},
                            {name: "delete", values: ["yes","no"], multiple: false},
                        ]
            },
            {
                class_name: "Banner",
                display_name: I18n.t(:banner),
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
            }
        ]
    end
end
