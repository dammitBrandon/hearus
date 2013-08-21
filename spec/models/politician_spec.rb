require 'spec_helper'

describe Politician do
  it { should be_instance(Politician)  }

  context 'testing validations' do
    it { should validate_presence_of(:first_name)  }
    it { should validate_presence_of(:last_name)  }
    it { should validate_presence_of(:party)  }
    it { should validate_presence_of(:state_id)  }
    it { should validate_presence_of(:district_id)  }
    it { should validate_presence_of(:website)  }
    it { should validate_presence_of(:webform)  }
    it { should validate_presence_of(:congress_office)  }
    it { should validate_presence_of(:bioguide_id)  }
    it { should validate_presence_of(:twitter_id)  }
    it { should validate_presence_of(:youtube_url)  }
    it { should validate_presence_of(:facebook_id)  }
    it { should validate_presence_of(:birthday)  }
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

  context 'testing associations' do
    it { should belong_to(:district)  }
  end

end
