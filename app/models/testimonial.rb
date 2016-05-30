class Testimonial < ActiveRecord::Base
    belongs_to :user
    
    def self.get_all_testimonials
        self.all.order("created_at DESC")
    end
    
    def self.sort_by
    [
      [I18n.t('created_at'), "testimonials.created_at"]
    ]
  end
  
  def self.sort_order
    [
      [I18n.t('asc'),"asc"],
      [I18n.t('desc'),"desc"],
    ]
  end
  
  def self.search(params)
    records = self.all
    
    #Search keyword filter
    if params[:keyword].present?
        records = records.where("LOWER(concat(testimonials.name,' ',testimonials.email,' ',testimonials.city,' ',testimonials.content)) LIKE ?", "%#{params[:keyword].downcase.strip}%")
    end
    
    # for sorting
    sort_by = params[:sort_by].present? ? params[:sort_by] : "testimonials.created_at"
    sort_order = params[:sort_order].present? ? params[:sort_order] : "asc"
    records = records.order("#{sort_by} #{sort_order}")
    
    return records
  end
end
