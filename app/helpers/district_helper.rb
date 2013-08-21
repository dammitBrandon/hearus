module DistrictHelper
  def get_location
    district ||= Location.get_zipcode(params[:zipcode])  if params[:zipcode]
    district ||= Location.get_coordinates("#{params[:address]}, #{params[:city]}, #{params[:state]}") if params[:address] && params[:city] && params[:state]
    district ||= Location.get_district_by_coordinates(params[:latitude], params[:longitude]) if params[:latitude] && params[:longitude]
    district
  end
end