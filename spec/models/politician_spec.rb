require 'spec_helper'

describe Politician do
  context 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:party) }
    it { should validate_presence_of(:bioguide_id) }
  end

  #context 'testing attr_accessible' do
  #  it { should allow_mass_assignment_of(:email)   }
  #  it { should allow_mass_assignment_of(:first_name)  }
  #  it { should allow_mass_assignment_of(:last_name)  }
  #  it { should allow_mass_assignment_of(:username)  }
  #  it { should allow_mass_assignment_of(:password)  }
  #  it { should allow_mass_assignment_of (:password_confirmation)  }
  #  it { should allow_mass_assignment_of(:district_id)  }
  #  it { should allow_mass_assignment_of(:district_number)  }
  #  it { should allow_mass_assignment_of(:rep_name)  }
  #end

  context 'associations' do
    it { should belong_to(:district)  }
  end

end
