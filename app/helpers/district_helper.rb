module DistrictHelper
  def get_location
    district = Location.get_zipcode(params[:zipcode])  if params[:zipcode]
    district ||= Location.get_coordinates("#{params[:address]}, #{params[:city]}, #{params[:state]}") if params[:address] && params[:city] && params[:state]
    district ||= Location.get_district_by_coordinates(params[:latitude], params[:longitude]) if params[:latitude] && params[:longitude]
    district
  end

  def format_district_number
    district_number = @legislators.first.district.number
    @district_number = "at large district" unless district_number > 0
    @district_number ||= district_number.ordinalize
  end
end
