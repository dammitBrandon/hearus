FactoryGirl.define do
  factory :senator do
    id '2'
    first_name  'Charles'
    last_name   'Schumer'
    bioguide_id 'G000555'
    party       'D'
    gender      'M'
  end

  factory :representative do
    id '1'
    first_name  'Yvette'
    last_name   'Schumez'
    bioguide_id 'C001067'
    party       'D'
    gender      'W'
  end
end
