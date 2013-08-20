class Vote < ActiveRecord::Base
  belongs_to :user
  attr_accessible :choice, :user_id, :bill_id
  validates_uniqueness_of :bill_id, :scope => :user_id

  def self.yes_votes(bill_id)
    where("bill_id = ? AND choice = ?", bill_id, "Yes")
  end

  def self.no_votes(bill_id)
    where("bill_id = ? AND choice = ?", bill_id, "No")
  end

  def self.no_opinion_votes(bill_id)
    where("bill_id = ? AND choice = ?", bill_id, "No Opinion")
  end

  def all_votes(bill_id)
    where("bill_id = ?", bill_id)
  end
end
