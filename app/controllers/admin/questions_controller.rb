class Admin::QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    # authorize
    authorize! :read, Question
    
    @questions = Question.search(params).paginate(:page => params[:page], :per_page => 10)
  end
  
  def search
    # authorize
    authorize! :read, Question
    
    @questions = Question.search(params).paginate(:page => params[:page], :per_page => 10)
    render "admin/questions/index"
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    # authorize
    authorize! :create, Question
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
    # authorize
    authorize! :update, @question
  end

  # POST /questions
  # POST /questions.json
  def create
    # authorize
    authorize! :create, Question
    @question = Question.new(question_params)
    
    respond_to do |format|
      if @question.save
        format.html { redirect_to controller: "product", action: "product", product_id: @question.id }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    # authorize
    authorize! :update, @question
    
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    # authorize
    authorize! :delete, @question
    
    @question.destroy
    
    render nothing:true
    flash[:notice] = 'Xóa câu hỏi của khách hàng thành công.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:name, :email, :content, :product_id, :user_id)
    end
end
