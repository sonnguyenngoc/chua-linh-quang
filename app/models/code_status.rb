class CodeStatus < ActiveRecord::Base
    validates :title, presence: true
    
    def self.get_all_statuses
        self.all.order("created_at ASC")
    end
    
    def self.sort_by
    [
      ["Title","code_statuses.title"],
      ["Created At","code_statuses.created_at"],
    ]
    end
    
    def self.sort_order
      [
        ["ASC","asc"],
        ["DESC","desc"],
      ]
    end
    
    def self.search(params)
        records = self.all
        
        #Search keyword filter
        if params[:keyword].present?
            records = records.where("LOWER(CONCAT(code_statuses.title,' ',code_statuses.description)) LIKE ?", "%#{params[:keyword].downcase.strip}%")
        end
        
        # for sorting
        sort_by = params[:sort_by].present? ? params[:sort_by] : "code_statuses.title"
        sort_order = params[:sort_order].present? ? params[:sort_order] : "asc"
        records = records.order("#{sort_by} #{sort_order}")
        
        return records   
    end
end
