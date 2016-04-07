class ApplicationController < ActionController::Base
  layout :layout_by_resource
  protect_from_forgery with: :exception
  
  protected
    def layout_by_resource
      if controller_name == "home" || controller_name == "account" || controller_name == "checkout" || controller_name == "blog" ||
        controller_name == "information" || controller_name == "manufacturer" || controller_name == "product"
        "frontend"
      elsif controller_name == "main"
        "backend"
      end
    end
end
