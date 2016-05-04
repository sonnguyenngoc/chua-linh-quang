class Users::PasswordsController < Devise::PasswordsController
  protected
    def after_resetting_password_path_for(resource)
<<<<<<< HEAD
      my_account_path
=======
      signed_in_root_path(resource)
>>>>>>> 207f992434023709bf4639942a1f71a4dd9431be
    end
end