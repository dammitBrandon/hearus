module ApplicationHelper
  require "sunlight"
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def current_district
    @current_district||= District.find_by_id(session[:district_id])
  end
end


