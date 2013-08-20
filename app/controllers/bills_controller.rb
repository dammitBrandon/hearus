class BillsController < ApplicationController
  def find
    @bills = Bill.search_query(params[:search])
  end

  def show
    @errors = params[:errors]
    puts "*" * 100
    p current_user?
    p session[:user_id]
    p current_user == true
    @vote = Vote.new
    @bill = Bill.view_bill(params[:id])
    #all keys are strings
    #chamber
    #congress
    #cosponsors
    #house_passage_result
    #senate_passage_result
    #number
    #short_title
    #sponsor_id
    #urls => #congress, #govtrack, #opencongress
  end

  def create
  end


end
