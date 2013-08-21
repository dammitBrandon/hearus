class Location
  def self.get_zipcode(zipcode)
    if zipcode.class == String
      self.set_district_by_zipcode(zipcode.strip.to_i)
    else
      self.set_district_by_zipcode(zipcode)
    end
  end

  def self.set_district_by_zipcode(zipcode)
    legislators = Sunlight::Legislator.all_in_zipcode(zipcode)
    rep = legislators.find { |leg| leg.title == 'Rep' }
    if legislators.length == 3 || legislators.length == 1
      District.where("state_abbreviation = ? AND number = ?", rep.state, rep.district.to_i ).first
    else
      false
    end
  end

  def self.get_coordinates(address)
    get_district_by_coordinates(*(Geocoder.coordinates(address)))
  end

  private

  def self.get_district_by_coordinates(latitude, longitude)
    district = Sunlight::District.get(:latitude => latitude,:longitude => longitude)
    District.find_by_sunlight_district(district)
  end
end
