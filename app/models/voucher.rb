class Voucher < ActiveRecord::Base
  
  def codes
    code.split(",")
  end
  
  def self.is_valid_code(code)
    voucher = Voucher.get_by_code(code)
    if voucher.nil?
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
    
    self.code = arr.join(",")
  end
  
  def generate_code
    code = create_code
 
    #ensure that the voucher code is unique.
    @voucher = Voucher.where("code LIKE ?", "%#{code}%").first
    while !@voucher.nil?
      code = create_code
      @voucher = Voucher.where("code LIKE ?", "%#{code}%").first
    end
 
    return code
  end
  
  def self.get_by_code(code)
    self.where("Lower(code) Like ? ", "%#{code.downcase.strip}%").first
  end
 
  protected
  def create_code
    chars = ("0".."9").to_a
 
    code = ""
    1.upto(8) { |i| 
      code << chars[rand(chars.size-1)] 
      if i % 4 == 0 && i < 8
        code << "-"
      end
    }
    return code
  end
end
