# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

CSV.foreach("db/shapes.csv", headers: true, header_converters: :symbol) do |row|
  state, number = row[:twodigit_districts].split('-')
  district = District.find_by_state_abbreviation_and_number(state, number.to_i)
  if district
    DistrictShape.create(shape: row[:shape], district: district)
  else
    puts row
  end
end
