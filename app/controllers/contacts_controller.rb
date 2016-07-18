class ContactsController < ApplicationController
  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)
    @contact.save
    redirect_to send_contact_success_path
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:name, :email, :phone, :address, :unit, :message)
    end
end
