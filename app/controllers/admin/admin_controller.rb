class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  redirect_to root_path if current_user.is_admin != true
  layout "backend"
end