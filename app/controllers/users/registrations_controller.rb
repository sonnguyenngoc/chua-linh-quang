class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [:new, :destroy, :create, :cancel]
  prepend_before_action :authenticate_scope!, only: [:edit, :update, :destroy]
  
   # POST /resource
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_in_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_in_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      #respond_with resource
      redirect_to controller: "/account", action: "register"
    end
  end

  private
    def sign_up_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone, :fax, :company, :address_1, :address_2, :city, :zip_code, :country, :province, :password, :password_confirmation)
    end
    def account_update_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone, :fax, :company, :address_1, :address_2, :city, :zip_code, :country, :province, :password, :password_confirmation, :current_password)
    end
end