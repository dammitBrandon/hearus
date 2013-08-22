require "spec_helper"

describe District do
  context "describe associations" do
    it { should have_one(:representative)}
    it { should belong_to(:state)}
    it { should have_many(:users)}
  end

  context 'validations' do
    it { should validate_presence_of(:state_full_name) }
    it { should validate_presence_of(:rep_name) }
    it { should validate_presence_of(:state_id) }
    it { should validate_presence_of(:state_abbreviation) }
  end
end
