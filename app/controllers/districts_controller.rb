class DistrictsController < ApplicationController
  include DistrictHelper
  include LegislatorHelper

  def show
    if params[:bioguide_id]
      @legislators = [Politician.find_by_bioguide_id(params[:bioguide_id])]
    elsif current_district
      @legislators = [current_district.representative]
      @legislators << current_district.state.senators.first if current_district.state.senators
      @legislators << current_district.state.senators.last if current_district.state.senators
      @legislator = Politician.first
    else
      redirect_to root_path
    end
  end

  def find
    @states = State.all
  end

  def set
    district = get_location
    if district
      session[:district_id] = district.id
      current_user.set_legislators(district.id) if current_user
      redirect_to district_path(district)
    else
      redirect_to find_districts_path
    end
  end
end
