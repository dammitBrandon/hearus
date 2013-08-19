class BillsController < ApplicationController
  def find
  end

  def view
    Bill.view_bill(params[:bill_id])
  end

  def create
  end
end
