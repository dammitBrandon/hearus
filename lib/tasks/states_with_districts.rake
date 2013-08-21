namespace :seed do
  desc 'Add all states'
    task :states => :environment do
      states = [["AK", "Alaska"],
                ["AL", "Alabama"],
                ["AR", "Arkansas"],
                ["AZ", "Arizona"],
                ["CA", "California"],
                ["CO", "Colorado"],
                ["CT", "Connecticut"],
                ["DC", "District of Columbia"],
                ["DE", "Delaware"],
                ["FL", "Florida"],
                ["GA", "Georgia"],
                ["HI", "Hawaii"],
                ["IA", "Iowa"],
                ["ID", "Idaho"],
                ["IL", "Illinois"],
                ["IN", "Indiana"],
                ["KS", "Kansas"],
                ["KY", "Kentucky"],
                ["LA", "Louisiana"],
                ["MA", "Massachusetts"],
                ["MD", "Maryland"],
                ["ME", "Maine"],
                ["MI", "Michigan"],
                ["MN", "Minnesota"],
                ["MO", "Missouri"],
                ["MS", "Mississippi"],
                ["MT", "Montana"],
                ["NC", "North Carolina"],
                ["ND", "North Dakota"],
                ["NE", "Nebraska"],
                ["NH", "New Hampshire"],
                ["NJ", "New Jersey"],
                ["NM", "New Mexico"],
                ["NV", "Nevada"],
                ["NY", "New York"],
                ["OH", "Ohio"],
                ["OK", "Oklahoma"],
                ["OR", "Oregon"],
                ["PA", "Pennsylvania"],
                ["RI", "Rhode Island"],
                ["SC", "South Carolina"],
                ["SD", "South Dakota"],
                ["TN", "Tennessee"],
                ["TX", "Texas"],
                ["UT", "Utah"],
                ["VA", "Virginia"],
                ["VT", "Vermont"],
                ["WA", "Washington"],
                ["WI", "Wisconsin"],
                ["WV", "West Virginia"],
                ["WY", "Wyoming"] ]
      states.each do |state|
        State.create(abbreviation: state[0], full_name: state[1] )
        puts "#{state[0]} created!"
      end
    end

  desc 'Add all congressional districts'
    task :districts => :environment do
      all_states = []
      State.all.each do |state|
        all_states << Sunlight::Legislator.all_where(:state => state.abbreviation)
        puts "#{state.full_name} ready for districting!"
      end

      all_states.each do |state|
        state.each do |leg|
          if leg.title == "Rep"
            district = District.new
              district.number = leg.district.to_i
              district.state = State.find_by_abbreviation(leg.state)
              district.state_full_name = district.state.full_name
              district.state_abbreviation = leg.state
              district.rep_name = "#{leg.title}. #{leg.firstname} #{leg.lastname}"
              district.save
            rep = Representative.new
              rep.first_name = leg.firstname
              rep.last_name = leg.lastname
              rep.district_id = district.id
              rep.state_id = district.state.id
              rep.party = leg.party
              rep.twitter_id = "@#{leg.twitter_id}"
              rep.facebook_id = leg.facebook_id
              rep.youtube_url = leg.youtube_url
              rep.bioguide_id = leg.bioguide_id
              rep.birthday = leg.birthdate
              rep.webform = leg.webform
              rep.website = leg.website
              rep.phone = leg.phone
              rep.gender = leg.gender
              rep.congress_office = leg.congress_office
              rep.congresspedia_url = leg.congresspedia_url
              rep.webform = "https://walden.house.gov/e-mail-greg" if rep.last_name == "Walden"
              puts "Rep. #{rep.first_name} #{rep.last_name} saved!" if rep.save
          else
            sen = Senator.new
              sen.first_name = leg.firstname
              sen.last_name = leg.lastname
              sen.state_id = State.find_by_abbreviation(leg.state).id
              sen.party = leg.party
              sen.twitter_id = "@#{leg.twitter_id}"
              sen.facebook_id = leg.facebook_id
              sen.youtube_url = leg.youtube_url
              sen.bioguide_id = leg.bioguide_id
              sen.birthday = leg.birthdate
              sen.webform = leg.webform
              sen.website = leg.website
              sen.phone = leg.phone
              sen.gender = leg.gender
              sen.congress_office = leg.congress_office
              sen.congresspedia_url = leg.congresspedia_url
              puts "Sen. #{sen.first_name} #{sen.last_name} saved!" if sen.save
          end
        end
      end
    end

  desc "Add states and districts"
    task :add_all => [:states, :districts] do
      puts "states and districts creation complete!"
    end

end

