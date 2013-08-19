class BillsController < ApplicationController
  def find
    @bills = Bill.search_query(params[:search])
  end

  def view
  end

  def create
  end
end
