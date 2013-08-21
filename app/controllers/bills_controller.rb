class BillsController < ApplicationController
  include SunlightHelper

  def find
    @bills = search_query(params[:search])
  end

  def show
    @errors = params.fetch(:errors, [])
    @bill = view_bill(params[:id])
    if current_user
    @vote = Vote.find_by_user_id_and_sunlight_id(current_user.id, @bill["bill_id"]) || Vote.new
    end

    choice = Struct.new(:intent, :colloquial)
    @choices = [
      choice.new("Yes", "Yea"),
      choice.new("No", "Nea"),
      choice.new("No Opinion", "No Opinion"),]
  end
end
