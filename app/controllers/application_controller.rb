class ApplicationController < ActionController::Base
  before_action :set_locale
  
  protect_from_forgery
  
  layout :layout_by_resource
  protect_from_forgery with: :exception
  
  protected
    def layout_by_resource
      if controller_name == "home" || controller_name == "contact" || controller_name == "buddhist_family" || controller_name == "cultural" || controller_name == "news" ||
         controller_name == "charity" || controller_name == "buddhist_news" || controller_name == "buddhist_book" || controller_name == "blog_detail" || controller_name == "feedback"
        "frontend"
      elsif controller_name == "coming_soon"
        "coming_soon"
      elsif (devise_controller? && resource_name == :user && action_name != 'edit') || controller_name == 'passwords'
        "login"
      elsif controller_name == "main" || controller_name == "products" || controller_name == "categories" || controller_name == "manufacturers" ||
            controller_name == "articles" || controller_name == "article_categories" || controller_name == "areas" || controller_name == "orders" || controller_name == "slideshows" ||
            controller_name == "delivery_methods" || controller_name == "payment_methods" || controller_name == "comments" || controller_name == "questions" || controller_name == "customers" ||
            controller_name == "coupons" || controller_name == "vouchers" || controller_name == "comment_articles" || controller_name == "companies" || controller_name == "code_statuses" || controller_name == "testimonials" ||
            controller_name == "options" || controller_name == "users" || controller_name == "user_groups" || controller_name == "contacts" || controller_name == "newsletters"

          authenticate_user!
          redirect_to root_path if current_user.is_admin != true
          "backend"
      end
    end
    
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  def extract_locale_from_tld
    parsed_locale = request.host.split('.').last
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end
  
  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end
end
