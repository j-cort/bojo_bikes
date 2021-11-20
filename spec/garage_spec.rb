require 'garage'

describe Garage do
  context "(repairing bikes)" do

    it "allows user to load working/fixed bikes into the back of the van" do 
      expect(subject).to respond_to(:load_fixed_into)
    end

    it "raises an error if there are fewer than 5 working bikes in the workshop to be loaded int the van" do
      b1 = Bike.new
      b1.report_broken
      subject.workshop << b1
      4.times { subject.workshop << Bike.new }
      van = Van.new
      expect{ subject.load_fixed_into(van) }.to raise_error "You must prepare at least 5 working bikes for collection"
    end

    # it "removes all working bikes from gara"

  end
end