class ContactsController < ApplicationController

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if verify_recaptcha(model: @contact) && @contact.save
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
