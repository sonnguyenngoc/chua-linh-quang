# encoding: utf-8

class ArticleUploader < CarrierWave::Uploader::Base

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
  version :big_image do
    process :resize_to_fill => [1170, 356]
  end
  version :largest_image do
    process :resize_to_fill => [848, 380]
  end
  version :larger_image do
    process :resize_to_fill => [770, 380]
  end
  version :large_image do
    process :resize_to_fill => [670, 300]
  end
  version :medium_image do
    process :resize_to_fill => [368, 300]
  end
  version :smallest_image do
    process :resize_to_fill => [243, 180]
  end
  version :smaller_image do
    process :resize_to_fill => [170, 70]
  end
  version :small_2_image do
    process :resize_to_fill => [100, 88]
  end
  version :small_image do
    process :resize_to_fill => [100, 80]
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
