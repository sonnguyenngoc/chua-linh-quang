class Admin::NewslettersController < ApplicationController

  # GET /newsletters/new
  def new
    @newsletter = Newsletter.new
  end


  # POST /newsletters
  # POST /newsletters.json
  def create
    @newsletter = Newsletter.new(newsletter_params)

    respond_to do |format|
      if @newsletter.save
        format.html { redirect_to [:admin, @newsletter], notice: 'Cảm ơn bạn đã đăng ký nhận tin mới từ website chúng tôi.' }
        format.json { render :show, status: :created, location: @newsletter }
      else
        format.html { render :new }
        format.json { render json: @newsletter.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_newsletter
      @newsletter = Newsletter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def newsletter_params
      params.require(:newsletter).permit(:email)
    end
end
