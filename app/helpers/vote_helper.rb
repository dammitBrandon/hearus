module VoteHelper
  def bill
   Bill.view_bill(@vote.bill_id)
  end

  def voter
    User.find(@vote.user_id)
  end

  def yes
   Vote.yes_votes(@vote.bill_id)
  end

  def no
    Vote.no_votes(@vote.bill_id)
  end

  def no_opinion
   Vote.no_opinion_votes(@vote.bill_id)
  end

  def total_votes
    Vote.all_votes(@vote.bill_id)
  end
end
