class DistrictController < ApplicationController
  def index
  end

  def create
    puts params[:zipcode]
  end

end
