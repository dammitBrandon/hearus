require 'spec_helper'

describe UserFactory do
  describe "#create" do
    let(:user_attributes) {{
      first_name: "Carlin",
      last_name: "Biles",
      user_name: "Carlin",
      email: "carlin.biles@gmail.com",
      password: "12345",
      password_confirmation: "12345"
      address: "12507 Macduff Drive, Fort Washington Md, 20744"
    }}
    let(:factory) { UserFactory.new(user_attributes) }
    it "saves a User and their district information"
  end
end
