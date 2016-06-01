class Admin::MainController < ApplicationController
  def index
    authorize! :read, User.new
  end
end
