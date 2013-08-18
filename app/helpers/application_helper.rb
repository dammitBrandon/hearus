module ApplicationHelper
  def get_zipcode(zipcode)
    if zipcode.class == String
      set_district_by_zipcode(zipcode.strip.to_i)
    else
      set_district_by_zipcode(zipcode)
    end
  end

  def get_coordinates(address)
    coordinates = Geocoder.coordinates(address)
    latitude = coordinates[0]
    longitude = coordinates[1]
    set_district_by_coordinates(latitude,longitude)
  end

  protected

  def set_district_by_zipcode(zipcode)
    legislators = Sunlight::Legislator.all_in_zipcode(zipcode)
    if legislators.length == 3
      legislators.each do |leg|
        if leg.title == "Rep"
          district = District.where("state_name = ? AND number = ?", leg.state, leg.district.to_i )[0]
        end
      end
    return district
   else
    false
   end
  end

  def set_district_by_coordinates(latitude,longitude)
    district = Sunlight::District.get(:latitude => latitude,
                                      :longitude => longitude)
    District.where("state_name = ? AND number = ?", district.state, district.number.to_i )[0]
  end
end

