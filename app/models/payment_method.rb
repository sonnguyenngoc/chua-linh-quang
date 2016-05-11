class PaymentMethod < ActiveRecord::Base
  
  def self.search(params)
    records = self.all
    
    #Search keyword filter
    if params[:keyword].present?
        records = records.where("LOWER(payment_methods.title) LIKE ?", "%#{params[:keyword].downcase.strip}%")
    end
    
    return records   
  end
  
  def self.get_all_payment_methods
    self.all.order("created_at DESC")
  end
  
end
