class DistrictController < ApplicationController
  def index
  end

  def create
    @latlong = params[:zipcode]
  end

end
