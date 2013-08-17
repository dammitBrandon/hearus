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
        State.create(name: state[0])
        puts "#{state[0]} created!"
      end
    end

  desc 'Add all congressional districts'
    task :districts => :environment do
      all_states = []
      State.all.each do |state|
        all_states << Sunlight::Legislator.all_where(:state => state.name)
        puts "#{state.name} ready for districting!"
      end

      all_states.each do |state|
        state.each do |rep|
          if rep.title == "Rep"
            district = District.new
              district.number = rep.district.to_i
              district.state = State.find_by_name(rep.state)
              district.state_name = rep.state
              district.rep_name = "#{rep.title} #{rep.firstname} #{rep.lastname}"
              district.rep_phone = rep.phone
              district.rep_email_form = rep.webform
              district.rep_party = rep.party
              district.rep_twitter = "@#{rep.twitter_id}"
              district.rep_facebook = rep.facebook_id
              district.rep_youtube = rep.youtube_url
              district.rep_wiki = rep.congresspedia_url
            if district.save
              puts "#{district.state_name} district:#{district.number} saved!"
            else
              puts "Save failed, here's why: #{district.errors.full_messages}"
            end
          end
        end
      end
    end

  desc "Add states and districts"
    task :add_all => [:states, :districts] do
      add_all
      puts "states and districts creation complete!"
    end

end

