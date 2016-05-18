class Comment < ActiveRecord::Base
  validates :name, :content, :star, presence: true
  belongs_to :product
  belongs_to :user
  
  def self.sort_by
    [
      ["Created At", "comments.created_at"]
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
    
    # Article filter
    if params[:article_id].present?
        records = records.where(article_id: params[:article_id])
    end
    
    #Search keyword filter
    if params[:keyword].present?
        records = records.joins(:product).where("LOWER(CONCAT(comments.content,' ',comments.name,' ',products.name)) LIKE ?", "%#{params[:keyword].downcase.strip}%")
    end
    
    # for sorting
    sort_by = params[:sort_by].present? ? params[:sort_by] : "comments.created_at"
    sort_order = params[:sort_order].present? ? params[:sort_order] : "asc"
    records = records.order("#{sort_by} #{sort_order}")
    
    return records
  end

end
