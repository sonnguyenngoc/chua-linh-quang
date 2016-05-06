class Company < ActiveRecord::Base
    mount_uploader :image_url, CompanyUploader
    
    def self.get_company
        self.all.order("created_at DESC").first
    end
end
