class Question < ActiveRecord::Base
  validates :name, :email, :content, presence: true
  belongs_to :product
  
  def self.sort_by
    [
      ["Created At", "questions.created_at"]
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
    
    # Product filter
    if params[:product_id].present?
        records = records.where(product_id: params[:product_id])
    end
    
    #Search keyword filter
    if params[:keyword].present?
        records = records.where("LOWER(questions.content) LIKE ?", "%#{params[:keyword].downcase.strip}%")
    end
    
    # for sorting
    sort_by = params[:sort_by].present? ? params[:sort_by] : "questions.created_at"
    sort_order = params[:sort_order].present? ? params[:sort_order] : "asc"
    records = records.order("#{sort_by} #{sort_order}")
    
    return records
  end
  
end
