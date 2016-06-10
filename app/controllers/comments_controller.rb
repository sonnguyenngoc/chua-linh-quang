class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id if current_user.present?
    
    respond_to do |format|
      if @comment.save
        format.html { redirect_to controller: "product", action: "product", product_id: @comment.product_id }
      else
        flash[:notice] = "Đánh giá sản phẩm không thành công"
        format.html { redirect_to controller: "product", action: "product", product_id: @comment.product_id }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to controller: "product", action: "product", product_id: @comment.product_id }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:product_id, :name, :content, :star, :user_id)
    end
end
