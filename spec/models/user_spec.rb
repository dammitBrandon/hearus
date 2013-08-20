require 'spec_helper'

describe User do
  it { should be_instance_of(User) }

  context 'testing attr_accessible' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
    it { should validate_presence_of(:district) }
    it { should validate_presence_of(:district_number) }
    it { should validate_presence_of(:rep_name) }
  end

  context 'testing associations' do
      it { should belong_to(:district) }
      it { should have_many(:votes) }
      it { should have_many(:accounts) }
  end

  it 'should return an existing user' do
    user = Factory.create(:user)
    expect(User.)
  end
end
