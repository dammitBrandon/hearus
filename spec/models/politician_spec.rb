require 'spec_helper'

describe Politician do
  context 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:party) }
    it { should validate_presence_of(:bioguide_id) }
    it { should validate_presence_of(:gender)}
    it { should validate_presence_of(:phone)}
    it { should validate_presence_of(:birthday)}
  end
end
