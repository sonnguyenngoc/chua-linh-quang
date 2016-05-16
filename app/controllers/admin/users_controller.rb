class Admin::UsersController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  
  def index
    @users = User.search(params).paginate(:page => params[:page], :per_page => 10)
  end
  
  def search
    @users = User.search(params).paginate(:page => params[:page], :per_page => 10)
    render "admin/users/index"
  end
end
