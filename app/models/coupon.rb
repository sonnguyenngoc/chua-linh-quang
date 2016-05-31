class Coupon < ActiveRecord::Base
  
  def codes
    code.split("][").map {|s| s.gsub("]","").gsub("[","") }
  end
  
  def self.is_valid_code(code)
    coupon = Coupon.get_by_code(code)
    if coupon.nil?
      return false
    else      
      return true
    end    
  end
  
  def generate_codes
    arr = []
    (1..quantity).each do |code|
      c = generate_code
      while arr.include?(c)
        c = generate_code
      end
      arr << c
    end
    
    self.code = "["+arr.join("][")+"]"
  end
  
  def generate_code
    code = create_code
 
    #ensure that the coupon code is unique.
    @coupon = Coupon.where("code LIKE ?", "%[#{code}]%").first
    while !@coupon.nil?
      code = create_code
      @coupon = Coupon.where("code LIKE ?", "%[#{code}]%").first
    end
 
    return code
  end
  
  def self.get_by_code(code)
    self.where("Lower(code) Like ? ", "%[#{code.downcase.strip}]%").first
  end
 
  protected
  def create_code
    chars = ("A".."Z").to_a
 
    code = ""
    1.upto(8) { |i| 
      code << chars[rand(chars.size-1)] 
      if i % 4 == 0 && i < 8
        code << "-"
      end
    }
    return code
  end
  
  #Filter, search
  def self.sort_by
    [
      [I18n.t('created_at'),"coupons.created_at"]
    ]
  end
  def self.sort_order
    [
      [I18n.t('asc'), "asc"],
      [I18n.t('desc'), "desc"],
    ]
  end
  def self.search(params)
    records = self.all
    
    #From Date filter
    if params[:valid_date].present?
      records = records.where('coupons.from_date <= ? AND coupons.to_date >= ?', params[:valid_date], params[:valid_date])
    end
    
    #Search keyword filter
    if params[:keyword].present?
        records = records.where("LOWER(coupons.name) LIKE ?", "%#{params[:keyword].downcase.strip}%")
    end
    
    # for sorting
    sort_by = params[:sort_by].present? ? params[:sort_by] : "coupons.created_at"
    sort_order = params[:sort_order].present? ? params[:sort_order] : "asc"
    records = records.order("#{sort_by} #{sort_order}")
    
    return records   
  end
  
end
