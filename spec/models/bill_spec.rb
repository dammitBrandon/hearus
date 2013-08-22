require 'spec_helper'

describe Bill do
  # before :each do
    # @bill = Bill.new("hr-557")
  let(:bill) {Bill.new("hr-557")}
    # puts @bill

  # end

  it "should be an instance of a Bill object" do
    puts "7" * 100
    p bill
    (bill).should be_an_instance_of Bill
  end

  it "returns the correct id" do
    bill.id.should eql "hr-557"
  end

  context "it eturns the correct votes" do
    it "should have 0 yes votes" do
      bill.yes.should be_empty
    end
    it "should have 0 no votes" do
      bill.no.should be_empty
    end
    it "should have 0 no opinion votes" do
      bill.no_opinion.should be_empty
    end
     it "should have 0% yes votes" do
      bill.percent_yes.should eql "0%"
    end
    it "should have 0% no votes" do
      bill.percent_no.should eql "0%"
    end
    it "should have 0% no opinion votes" do
      bill.percent_no_opinion.should eql "0%"
    end
  end

end
