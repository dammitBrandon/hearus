require "spec_helper"

describe State do
  context 'testing attr_accessible' do
    it { should validate_presence_of(:abbreviation)  }
    it { should validate_uniqueness_of(:abbreviation)  }
    it { should validate_presence_of(:full_name)  }
    it { should validate_uniqueness_of(:full_name)  }
  end

  context "describe associations" do
    it { should have_many(:districts)}
    it { should have_many(:representatives)}
    it { should have_many(:senators)}
    it { should have_many(:users)}
    it { should have_many(:politicians)}
  end

  context 'testing attr_accessible' do
    it { should allow_mass_assignment_of(:abbreviation)   }
    it { should allow_mass_assignment_of(:full_name)  }
  end
end
