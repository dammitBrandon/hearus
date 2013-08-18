APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do

  provider :facebook, ENV['HEARUS_FACEBOOK_ID'], ENV['HEARUS_FACEBOOK_SECRET']

  provider :foursquare, APP_CONFIG['foursquare_id'], APP_CONFIG['foursquare_secret'], {
    :client_options => { :ssl => APP_CONFIG["ssl_certs"] }
  }

  provider :twitter, ENV['HEARUS_TWITTER_ID'], ENV['HEARUS_TWITTER_SECRET']

  provider :linkedin, APP_CONFIG['linkedin_id'], APP_CONFIG['linkedin_secret'], :scope => APP_CONFIG["linkedin_permissions"]

end

Koala.http_service.http_options = { :ssl => { :verify => false } }
