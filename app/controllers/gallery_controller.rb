class GalleryController < ApplicationController
  def music
  end

  def picture
    @galleries = Gallery.get_all_galleries.paginate(:page => params[:page], :per_page => 12)
  end

  def video
  end
  
  def music_detail
    
  end
  
  def picture_detail
    @detail = Gallery.find(params[:picture_id])
  end
  
  def video_detail
  end
end
