class Company < ActiveRecord::Base
    mount_uploader :image_url, CompanyUploader
    validates :name, :phone, :email, :head_office_address, presence: true
    
    belongs_to :area, foreign_key: "head_area_id"
    belongs_to :area, foreign_key: "branch_area_id"
    
    def self.get_pagoda_info
        self.all.order("created_at DESC").first
    end
    
    def self.get_branch
        self.all.where(type_company: "Branch Office").order("created_at DESC")
    end
end
