class Vote < ActiveRecord::Base
  attr_accessible :choice, :user_id, :sunlight_id

  belongs_to :user

  validates_uniqueness_of :sunlight_id, :scope => :user_id
  validates_presence_of :choice, :user_id, :sunlight_id
  before_save :tweet_timestamp

  def tweet_timestamp
    if self.tweeted == 1
      self.tweeted_at =  Time.now.strftime('%Y-%m-%d %H:%M:%S.%L')
    else
      self.tweeted_at = nil
    end
  end
end
