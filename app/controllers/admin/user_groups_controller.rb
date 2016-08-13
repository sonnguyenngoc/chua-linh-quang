class Admin::UserGroupsController < ApplicationController
  before_action :set_user_group, only: [:show, :edit, :update, :destroy]

  # GET /user_groups
  # GET /user_groups.json
  def index
    authorize! :read, UserGroup
    @user_groups = UserGroup.all.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /user_groups/1
  # GET /user_groups/1.json
  def show
  end

  # GET /user_groups/new
  def new
    authorize! :create, UserGroup
    @user_group = UserGroup.new
  end

  # GET /user_groups/1/edit
  def edit
    authorize! :update, @user_group
  end

  # POST /user_groups
  # POST /user_groups.json
  def create
    authorize! :create, UserGroup
    @user_group = UserGroup.new(user_group_params)
    @user_group.permission = params[:permissions].to_json

    respond_to do |format|
      if @user_group.save
        format.html { redirect_to edit_admin_user_group_path(@user_group.id), notice: 'Tạo mới nhóm người dùng thành công.' }
        format.json { render :show, status: :created, location: @user_group }
      else
        format.html { render :new }
        format.json { render json: @user_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_groups/1
  # PATCH/PUT /user_groups/1.json
  def update
    authorize! :update, @user_group
    respond_to do |format|
      if @user_group.update(user_group_params)
        @user_group.permission = params[:permissions].to_json
        @user_group.save
        format.html { redirect_to edit_admin_user_group_path(@user_group.id), notice: 'Chỉnh sửa nhóm người dùng thành công.' }
        format.json { render :show, status: :ok, location: @user_group }
      else
        format.html { render :edit }
        format.json { render json: @user_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_groups/1
  # DELETE /user_groups/1.json
  def destroy
    # authorize
    authorize! :delete, @user_group
    @user_group.destroy
    
    render nothing:true
    flash[:notice] = 'Xóa nhóm thành công.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_group
      @user_group = UserGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_group_params
      params.require(:user_group).permit(:name, :permission)
    end
end
