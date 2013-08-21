module VoteHelper
  def new_vote(params)
    vote = Vote.new(
          :choice => params[:vote][:choice],
          :user_id => current_user.id,
          :sunlight_id => params[:vote][:sunlight_id])
    vote
  end
end
