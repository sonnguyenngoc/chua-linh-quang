class Users::PasswordsController < Devise::PasswordsController
  protected
    def after_resetting_password_path_for(resource)
      login_path
    end
end