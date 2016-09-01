class GalleryController < ApplicationController
  def music
    @musics = Album.get_all_musics.paginate(:page => params[:page], :per_page => 12)
  end

  def picture
    @galleries = Gallery.get_all_galleries.paginate(:page => params[:page], :per_page => 12)
  end

  def video
    @videos = Album.get_all_videos.paginate(:page => params[:page], :per_page => 12)
  end
  
  def music_detail
    @detail = Album.find(params[:music_id])
  end
  
  def picture_detail
    @detail = Gallery.find(params[:picture_id])
  end
  
  def video_detail
    @detail = Album.find(params[:video_id])
  end
end
