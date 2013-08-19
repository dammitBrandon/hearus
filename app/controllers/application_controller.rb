class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def current_user?
    false unless current_user
  end

  def current_district
    @current_district||= District.find_by_id(session[:district_id])
  end

  def current_district?
    true if current_district
  end

  def get_zipcode(zipcode)
    if zipcode.class == String
      set_district_by_zipcode(zipcode.strip.to_i)
    else
      set_district_by_zipcode(zipcode)
    end
  end

  def set_district_by_zipcode(zipcode)
    legislators = Sunlight::Legislator.all_in_zipcode(zipcode)
    if legislators.length == 3
      rep = legislators.find { |leg| leg.title == 'Rep' }
      District.where("state_abbreviation = ? AND number = ?", rep.state, rep.district.to_i ).first
    else
      false
    end
  end

  def get_coordinates(address)
    get_district_by_coordinates(*(Geocoder.coordinates(address)))
  end

  protected

  def get_district_by_coordinates(latitude, longitude)
    district = Sunlight::District.get(:latitude => latitude,:longitude => longitude)
    District.find_by_sunlight_district(district)
  end
end
