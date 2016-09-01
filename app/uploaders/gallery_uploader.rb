# encoding: utf-8

class GalleryUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end
  version :banner_image_250x250 do
    process :resize_to_fit => [250, 250]
  end
  version :banner_image_200x200 do
    process :resize_to_fit => [200, 200]
  end
  version :banner_image_300x250 do
    process :resize_to_fit => [300, 250]
  end
  version :small_image do
    process :resize_to_fit => [173, 173]
  end
  version :smaller_image do
    process :resize_to_fill => [136, 90]
  end
  version :smallest_image do
    process :resize_to_fit => [370, 230]
  end
  version :medium_image do
    process :resize_to_fit => [393, 178]
  end
  version :large_image do
    process :resize_to_fit => [640, 426]
  end
  version :main_banner do
    process :resize_to_fit => [1136, 227]
  end
  version :sub_banner do
    process :resize_to_fit => [1919, 191]
  end
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
