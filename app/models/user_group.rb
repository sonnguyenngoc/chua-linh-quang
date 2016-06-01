class UserGroup < ActiveRecord::Base
    validates :name, presence: true, uniqueness: true
    
    def permissions
        permission.present? ? JSON.parse(permission) : {}
    end
    
    def ability(model, action)
        (permissions[model].present? and permissions[model][action].present?) ? permissions[model][action] : ['no']
    end
end
