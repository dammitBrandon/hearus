class DistrictController < ApplicationController
  def index
  end

  def create
    @zipcode = params[:zipcode]
  end

end
