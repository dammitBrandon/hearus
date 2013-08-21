class Vote < ActiveRecord::Base
  attr_accessible :choice, :user_id, :sunlight_id

  belongs_to :user

  validates_uniqueness_of :user_id, :scope => :sunlight_id
  validates_presence_of   :user_id, :sunlight_id, :choice
end
