OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1238119839582178', '95c748070a2701da22e36e6ebd168208'
end