require 'spec_helper'

describe User do
  context 'testing validations' do
    it { should validate_presence_of(:email)  }
    it { should validate_presence_of(:password)  }
  end

  context "describe associations" do
    it { should have_many(:accounts)}
    it { should have_many(:votes)}
    it { should belong_to(:district)}
    it { should belong_to(:state)}
  end

  context 'testing attr_accessible' do
    it { should allow_mass_assignment_of(:email)   }
    it { should allow_mass_assignment_of(:first_name)  }
    it { should allow_mass_assignment_of(:last_name)  }
    it { should allow_mass_assignment_of(:username)  }
    it { should allow_mass_assignment_of(:password)  }
    it { should allow_mass_assignment_of (:password_confirmation)  }
  end
end
