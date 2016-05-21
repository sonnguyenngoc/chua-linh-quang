class Option < ActiveRecord::Base
  
  def self.get_meta_home_page
    self.where("code = 'home'").first
  end
  
  def self.get(tag)
    self.where(tag: tag).first
  end
  
  def self.get_user_guest
    self.where("tag = 'user.guest'").first
  end
  
end