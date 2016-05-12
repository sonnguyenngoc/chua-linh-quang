class ContactsController < ApplicationController
  
  def verify_google_recptcha(secret_key,response)
    status = `curl "https://www.google.com/recaptcha/api/siteverify?secret=#{secret_key}&response=#{response}"`
    logger.info "---------------status ==> #{status}"
    hash = JSON.parse(status)
    hash["success"] == true ? true : false
  end
  
  # POST /contacts
  # POST /contacts.json
  def create
    @secret_key = "6Le7mh8TAAAAAGKRPjxYnO9t0O1_m8dgxa-EgcOB"
    @contact = Contact.new(contact_params)
    status = verify_google_recaptcha(@secret_key, params["g-recaptcha-response"])
    respond_to do |format|
      if @contact.save && status
        format.html { redirect_to controller: "information", action: "finish_contact_us" }
      else
        flash[:notice] = "Post successfully created"
        format.html { redirect_to controller: "information", action: "contact_us" }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:name, :email, :message)
    end
end
