class InformationController < ApplicationController
  def about_us
    @title_head = "Về chúng tôi"
    @about_us =  Article.get_blog_about_us
  end
  
  def contact_us
    @title_head = "Liên hệ"
    @contact = Contact.new
  end
  
  def finish_contact_us
    @title_head = "Cảm ơn"
  end
  
  def finish_newsletter
    @title_head = "Cảm ơn"
  end
  
  def sitemap
    @title_head = "Sitemap"
  end
end
