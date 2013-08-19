class Vote < ActiveRecord::Base
  belongs_to :user
  attr_accessible :choice, :user_id, :bill_id
  validates_uniqueness_of :bill_id, :scope => :user_id
end
