require 'twitter'

Twitter.configure do |config|
  config.consumer_key = ENV['HEARUS_TWITTER_ID']
  config.consumer_secret = ENV['HEARUS_TWITTER_SECRET']
end
