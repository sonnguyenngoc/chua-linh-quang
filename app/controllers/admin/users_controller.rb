class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    # authorize
    #authorize! :read, User
    @areas = Area.get_by_level(2)
    
    @users = User.search(params).paginate(:page => params[:page], :per_page => 10)
  end
  
  def search
    @areas = Area.get_by_level(2)
    @users = User.search(params).paginate(:page => params[:page], :per_page => 10)
    render "admin/users/index"
  end
  
  def edit
    # authorize
   # authorize! :update, User
  end
  
  def update
    # authorize
    #authorize! :update, User
    
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to edit_admin_user_path(@user.id), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    # authorize
    # authorize! :delete, User
    
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:role, :first_name, :last_name, :email, :phone, :fax, :company, :address_1, :address_2, :city, :zip_code, :country, :province, :is_admin, :area_id, :user_group_id)
    end
end
