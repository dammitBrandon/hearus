class DistrictsController < ApplicationController
  include DistrictHelper

  def show
    if params[:bioguide_id]
      @district = District.find_by_bioguide_id(params[:bioguide_id])
    elsif current_district
      @district = current_district
    else
      redirect_to root_path
    end
    @district_number = "at large district" unless @district.number > 0
    @district_number ||= @district.number.ordinalize
  end

  def find
  end

  def set
    district = get_location
    if district
      session[:district_id] = district.id
      current_user.set_representative(district.id) if current_user
      redirect_to district_path(district)
    else
      redirect_to find_districts_path
    end
  end
end


