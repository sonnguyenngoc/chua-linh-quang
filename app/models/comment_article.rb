class CommentArticle < ActiveRecord::Base
  validates :name, :email, :content, presence: true
  belongs_to :article
  belongs_to :user
  
  def self.sort_by
    [
      ["Created At", "comment_articles.created_at"]
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
    
    # Article filter
    if params[:article_id].present?
        records = records.where(article_id: params[:article_id])
    end
    
    #Search keyword filter
    if params[:keyword].present?
        records = records.joins(:article).where("LOWER(CONCAT(comment_articles.content,' ',comment_articles.name,' ',articles.title)) LIKE ?", "%#{params[:keyword].downcase.strip}%")
    end
    
    # for sorting
    sort_by = params[:sort_by].present? ? params[:sort_by] : "comment_articles.created_at"
    sort_order = params[:sort_order].present? ? params[:sort_order] : "asc"
    records = records.order("#{sort_by} #{sort_order}")
    
    return records
  end
  
end
