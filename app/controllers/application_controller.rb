class ApplicationController < ActionController::Base
  layout :layout_by_resource
  protect_from_forgery with: :exception
  
  protected
    def layout_by_resource
      if controller_name == "home" || controller_name == "account" || controller_name == "checkout" || controller_name == "blog" ||
        controller_name == "information" || controller_name == "manufacturer" || controller_name == "product"
        "frontend"
      elsif (devise_controller? && resource_name == :user && action_name != 'edit') || controller_name == 'passwords'
        "login"
      elsif controller_name == "main" || controller_name == "products" || controller_name == "categories" || controller_name == "manufacturers" ||
            controller_name == "articles" || controller_name == "article_categories" || controller_name == "areas"
        authenticate_user!
        "backend"
      end
    end
end
