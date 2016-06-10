class Admin::CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  

  # GET /comments
  # GET /comments.json
  def index
    # authorize
    authorize! :read, Comment
    
    @comments = Comment.order("created_at DESC").search(params).paginate(:page => params[:page], :per_page => 10)
  end
  
  def search
    # authorize
    authorize! :read, Comment
    
    @comments = Comment.search(params).paginate(:page => params[:page], :per_page => 10)
    render "admin/comments/index"
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    # authorize
    authorize! :create, Comment
    
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    # authorize
    authorize! :update, @comment
  end

  # POST /comments
  # POST /comments.json
  def create
    # authorize
    authorize! :create, Comment
    @comment = Comment.new(comment_params)
    
    respond_to do |format|
      if @comment.save
        format.html { redirect_to edit_admin_comment_path(@delivery_method.id), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    # authorize
    authorize! :update, @comment
    
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to edit_admin_comment_path(@delivery_method.id), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    # authorize
    authorize! :delete, @comment
    @comment.destroy
    
    render nothing:true
    flash[:notice] = 'Xóa bình luận sản phẩm thành công.'
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
