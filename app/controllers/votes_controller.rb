class VotesController < ApplicationController
  include SunlightHelper
  before_filter :new_vote_authorized, only: [:create, :update]

  def create
    @vote = Vote.new(
      :choice => params[:vote][:choice],
      :user_id => current_user.id,
      :sunlight_id => params[:vote][:sunlight_id])
    if @vote.save
      redirect_to vote_path(@vote)
    else
      @errors = ["You can't vote twice!"]
      redirect_to :controller => "bills", :action => "show", :id => params[:vote][:sunlight_id], :errors => @errors
    end
  end

  def show
    @vote = Vote.find_by_id(params[:id])
    @bill = Bill.new(@vote.sunlight_id)
  end

  def update
    @vote = Vote.find(params[:id])
    @vote.update_attribute(:choice, params[:vote][:choice])
    redirect_to vote_path(@vote)
  end

  private

  def new_vote_authorized
    redirect_to new_session_path unless current_user
  end
end
