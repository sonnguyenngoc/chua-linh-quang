class CodeStatus < ActiveRecord::Base
    validates :title, presence: true
    
    def self.get_all_statuses
        self.all.order("created_at ASC")
    end
end
