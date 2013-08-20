class VotesController < ApplicationController
  include VoteHelper

  def create
    puts "*" * 7
    p params[:vote][:choice]
    @vote = Vote.new(
      :choice => params[:vote][:choice],
      :user_id => params[:vote][:user_id],
      :bill_id => params[:vote][:bill_id])
    if @vote.save
      @all_votes,@bill,@voter,@yes,@no,@no_opinion = all_votes,bill,voter,yes,no,no_opinion
      redirect_to vote_path(@vote)
    else
      @errors = @vote.errors.full_messages
      # redirect_to bill_path (unique_bill_id: params[:unique_bill_id], errors: @errors)
      redirect_to :controller => "bills", :action => "show", :id => params[:vote][:bill_id], :errors => @errors
    end
  end

  def update
  end

  def delete
  end

  def show
  end

end
