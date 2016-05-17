class Option < ActiveRecord::Base
  def self.get_meta_home_page
    self.all.where("code = 'home'").first
  end
  def self.get(tag)
    self.where(tag: tag).first
  end
end