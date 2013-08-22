module LegislatorHelper

  def legislator_title(leg)
    if leg
      title = leg.type + " " + leg.first_name
      title += " " + leg.last_name
      title
    else
      "Legislator"
    end
  end

  def birthday(leg)
    birthday = leg.birthday[0..10]
    birthday.gsub(/(\d{4})-(\d{2})-(\d{2})/,'\3-\2-\1')
    # .strftime("%M-%D-%Y")
  end

  def find_by_sponsor_id(sponsor_id)
    leg = Politician.find_by_bioguide_id(sponsor_id)
    legislator_title(leg)
  end

  def party_text(leg)
    if leg
      party = "Democrat" if leg.party == "D"
      party = "Republican" if leg.party == "R"
      party ||= leg.party
    else
      "Party"
    end
  end

  def gender_text(leg)
    if leg
      gender = "Female" if leg.gender == "F"
      gender ||= "Male"
    else
      "Gender"
    end
  end

end
