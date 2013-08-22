class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery

  before_filter :load_tweets

  def load_tweets
    twitter_accounts = Account.where(provider: "twitter")
    account = twitter_accounts.find_by_user_id(session[:user_id])
    if account
      @twitter_client = Twitter::Client.new(:oauth_token => account.oauth_token, :oauth_token_secret => account.oauth_secret)
    end
  end 
end
