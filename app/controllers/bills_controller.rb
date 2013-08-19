class BillsController < ApplicationController
  def find
    @bills = Bill.search_query(params[:search])
  end

  def show
    @bill = Bill.view_bill(params[:bill_id])
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
