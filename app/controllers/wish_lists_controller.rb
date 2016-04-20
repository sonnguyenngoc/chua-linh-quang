class WishListsController < ApplicationController
  before_action :set_wish_list, only: [:show, :destroy]

  # GET /wish_lists
  # GET /wish_lists.json
  def index
    @wish_lists = WishList.all
  end

  # GET /wish_lists/1
  # GET /wish_lists/1.json
  def show
  end

  # GET /wish_lists/new
  def new
    @wish_list = WishList.new
  end

  # POST /wish_lists
  # POST /wish_lists.json
  def create
    @wish_list = WishList.new(
      product_id: params[:product_id],
      user_id: params[:user_id]
    )
    respond_to do |format|
      if @wish_list.save
        format.html { redirect_to controller: "account", action: "wishlist" }
        format.json { render :show, status: :created, location: @wish_list }
      else
        format.html { render :new }
        format.json { render json: @wish_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wish_lists/1
  # DELETE /wish_lists/1.json
  def destroy
    @wish_list.destroy
    respond_to do |format|
      format.html { redirect_to controller: "account", action: "wishlist" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wish_list
      @wish_list = WishList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wish_list_params
      params.require(:wish_list).permit(:product_id, :user_id)
    end
end
