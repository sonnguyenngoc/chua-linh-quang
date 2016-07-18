class Admin::ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    # authorize
    authorize! :read, Contact
    
    @contacts = Contact.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    # authorize
    authorize! :read, Contact
    
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
    # authorize
    authorize! :read, @contact
  end

  # POST /contacts
  # POST /contacts.json
  def create
    # authorize
    authorize! :read, Contact
    @contact = Contact.new(contact_params)
  
    respond_to do |format|
      if @contact.save
        format.html { redirect_to [:admin, @contact], notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    # authorize
    authorize! :read, @contact
    
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to [:admin, @contact], notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    # authorize
    authorize! :delete, @contact
    @contact.destroy
    
    render nothing:true
    flash[:notice] = 'Xóa tin nhắn liên hệ thành công.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:name, :email, :phone, :address, :unit, :message)
    end
end
