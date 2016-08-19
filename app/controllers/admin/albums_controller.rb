class Admin::AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  # GET /albums
  # GET /albums.json
  def index
    authorize! :read, Album
    
    @albums = Album.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
  end

  # GET /albums/new
  def new
    authorize! :create, Album
    @album = Album.new
  end

  # GET /albums/1/edit
  def edit
    authorize! :update, @album
  end

  # POST /albums
  # POST /albums.json
  def create
    authorize! :create, Album
    @album = Album.new(album_params)
    @album.user_id = current_user.id

    respond_to do |format|
      if @album.save
        format.html { redirect_to edit_admin_album_path(@album.id), notice: 'Album was successfully created.' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    authorize! :update, @album
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to edit_admin_album_path(@album.id), notice: 'Album was successfully updated.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    # authorize
    authorize! :delete, @album
    @album.destroy
    
    render nothing:true
    flash[:notice] = 'Xóa album thành công.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:type_album, :image_url, :title, :description, :link, :user_id)
    end
end
