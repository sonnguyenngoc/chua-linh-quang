class Album < ActiveRecord::Base
  mount_uploader :image_url, GalleryUploader
  
  def self.get_all_videos
    self.where("albums.type_album = 'Video'").order("created_at DESC")
  end
  
  def self.get_all_musics
    self.where("albums.type_album = 'Music'").order("created_at DESC")
  end
end
