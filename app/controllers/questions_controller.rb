class QuestionsController < ApplicationController
  before_action :set_question, only: [:destroy]
  
  def verify_google_recaptcha(secret_key,response)
    status = `curl "https://www.google.com/recaptcha/api/siteverify?secret=#{secret_key}&response=#{response}"`
    logger.info "---------------status ==> #{status}"
    hash = JSON.parse(status)
    hash["success"] == true ? true : false
  end
  
  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @secret_key = "6Le7mh8TAAAAAGKRPjxYnO9t0O1_m8dgxa-EgcOB"
    @question.user_id = current_user.id if current_user.present?
    status = verify_google_recaptcha(@secret_key, params["g-recaptcha-response"])
    respond_to do |format|
      if @question.save
        format.html { redirect_to controller: "product", action: "product", product_id: @question.product_id }
      else
        flash[:notice] = "Đăng câu hỏi không thành công"
        format.html { redirect_to controller: "product", action: "product", product_id: @question.product_id }
      end
    end
  end
  
  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to controller: "product", action: "product", product_id: @question.product_id }
      format.json { head :no_content }
    end
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
