class TweetsController < ApplicationController

  def create
    if @twitter_client
      @twitter_client.update(params[:tweet])
    end
    if params[:vote_id]
      vote = Vote.find(params[:vote_id])
      vote.tweeted = 1
      vote.save
    end
    flash[:message] = "Tweet Successful"
    redirect_to :back
  end
end
