require 'spec_helper'

describe Bill do
  it { should be_instance_of(Bill) }
  context 'testing validation' do
    it { should validate_presence_of(:sunlight_id) }
  end
end
