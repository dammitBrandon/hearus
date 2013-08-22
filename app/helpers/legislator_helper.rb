module LegislatorHelper

  def legislator_title(leg)
    title = leg.type + " " + leg.first_name
    title += " " + leg.last_name
    title
  end

  def birthday(leg)
    "Born: " + leg.birthday[0..10]
    # .strftime("%M-%D-%Y")
  end

  def find_by_sponsor_id(sponsor_id)
    leg =Politician.find_by_bioguide_id(sponsor_id)
    legislator_title(leg)
  end
end
