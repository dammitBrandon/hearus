FactoryGirl.define do
  factory :user do
    id '21'
    first_name 'Gerrod'
    last_name 'Wilson'
    username 'GRod'
    email 'Gerrod.wilson@three_courts.com'
    password 'password'
    password_confirmation 'password'
    address = '851 Windward Court, Fort Washington, Md, 20744'
    latitude, longitude = Geocoder.coordinates(address)
    district = Sunlight::District.get(latitude: latitude, longitude: longitude)
    district_number = district.number
  end

  factory :vote do
    user
    sequence(:sunlight_id) {|n| n}
    tweeted 1
    choice "Yes"
  end
end
