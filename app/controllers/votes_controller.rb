class VoteController < ApplicationController.rb
  def create
    @vote = Vote.new(
      :choice => params[:vote],
      :user_id => current_user.id,
      :bill_id => params[:bill_id])
    if @vote.save
      redirect_to vote(@vote)
    else
      @errors = @vote.errors.full_messages
      # redirect_to bill_path (unique_bill_id: params[:unique_bill_id], errors: @errors)
      redirect_to bill(params[:bill_id])
    end
  end

  def update
  end

  def delete
  end

  def show
  end

end
