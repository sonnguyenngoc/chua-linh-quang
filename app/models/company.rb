class Company < ActiveRecord::Base
    mount_uploader :image_url, CompanyUploader
    belongs_to :area, foreign_key: "head_area_id"
    belongs_to :area, foreign_key: "branch_area_id"
    
    def self.get_company
        self.all.where(type_company: "Head Office").order("created_at DESC").first
    end
    
    def self.get_branch
        self.all.where(type_company: "Branch Office").order("created_at DESC")
    end
end
