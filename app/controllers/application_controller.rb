class ApplicationController < ActionController::Base
  before_action :set_locale
  include CurrentCart
  before_action :set_cart
  include CompareList
  before_action :set_compare
  
  layout :layout_by_resource
  protect_from_forgery with: :exception
  
  protected
    def layout_by_resource
      if controller_name == "home" || controller_name == "account" || controller_name == "checkout" || controller_name == "blog" ||
        controller_name == "information" || controller_name == "manufacturer" || controller_name == "product"
        "frontend"
      elsif controller_name == "account"
        authenticate_user!
      elsif (devise_controller? && resource_name == :user && action_name != 'edit') || controller_name == 'passwords'
        "login"
      elsif controller_name == "main" || controller_name == "products" || controller_name == "categories" || controller_name == "manufacturers" ||
            controller_name == "articles" || controller_name == "article_categories" || controller_name == "areas" || controller_name == "orders"
        authenticate_user!
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
  
  def after_sign_in_path_for(resource)
    if session[:user_return_to] == nil
      my_account_path
    else
      super
    end
  end
  
  def after_update_path_for(resource)
    my_account_path(resource)
  end
  
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
