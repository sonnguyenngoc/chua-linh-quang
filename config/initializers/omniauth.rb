OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['1238119839582178'], ENV['95c748070a2701da22e36e6ebd168208'], :display => "popup"
end