class Users::PasswordsController < Devise::PasswordsController
  protected
    def after_resetting_password_path_for(resource)
      my_account_path
    end
end