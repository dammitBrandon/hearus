require 'spec_helper'

describe Vote do
  context 'testing validations' do
    it { should validate_presence_of(:choice) }
    it { should validate_presence_of(:sunlight_id) }
    it { should validate_presence_of(:user_id) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:sunlight_id) }
  end

  context 'testing attr_accessible' do
    it { should allow_mass_assignment_of(:user_id) }
    it { should allow_mass_assignment_of(:sunlight_id) }
    it { should allow_mass_assignment_of(:choice) }
  end

  context 'testing associations' do
    it { should belong_to(:user) }
  end

  let (:vote) { FactoryGirl.create(:vote) }

  context "when a vote is saved" do
    it "should set tweet_timestamp" do
      vote.should_receive(:tweet_timestamp)
      vote.save
    end
  end

  describe "#tweet_timestamp" do
    it "should be set to current time" do
      vote.tweet_timestamp.should be_a String
    end

    it "should be nil if not tweeted" do
      vote.tweeted = 0
      vote.save
      vote.tweet_timestamp.should == nil
    end
  end
end
