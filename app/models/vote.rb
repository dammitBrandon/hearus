class Vote < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :bill_id, :scope => :user_id
end
