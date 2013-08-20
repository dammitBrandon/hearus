require 'spec_helper'

describe Vote do
  it { should be_instance_of(Vote) }

  context 'testing validations' do
    it { should validate_presence_of(:choice) }
    it { should validate_presence_of(:bill_id) }
    it { should validate_presence_of(:user_id) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:bill_id) }
  end

  context 'testing attr_accessible' do
    it { should allow_mass_assignment_of(:tweeted) }
    it { should allow_mass_assignment_of(:user_id) }
    it { should allow_mass_assignment_of(:bill_id) }
    it { should allow_mass_assignment_of(:choice) }
  end

  context 'testing associations' do
    it { should belong_to(:user) }
  end
end
