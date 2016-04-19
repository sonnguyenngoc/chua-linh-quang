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
  
  def delivery
    @delivery_information = Article.where(code: "delivery_information").first
    @title_head = @delivery_information.title
  end
  
  def privacy_policy
    @privacy_information = Article.where(code: "privacy_policy").first
    @title_head = @privacy_information.title
  end
  
  def terms_conditions
    @terms_information = Article.where(code: "terms_conditions").first
    @title_head = @terms_information.title
  end

end
