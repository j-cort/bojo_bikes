require 'garage'
# how does garage know what Van or Bike is???
describe Garage do
  before(:each) do
    @van = Van.new
    @b1, @b2, @b3, @b4 = Bike.new, Bike.new, Bike.new, Bike.new
    @b1.report_broken 
    @b2.report_broken
    subject.workshop << @b1 
    subject.workshop << @b2
    subject.workshop << @b3 
    subject.workshop << @b4  
    Garage::MIN_REQ_WORKING_BIKES.times { subject.workshop << Bike.new }
  end

  context "(repairing bikes)" do

    it "allows user to load working/fixed bikes into the back of the van" do 
      expect(subject).to respond_to(:load_fixed_into)
    end

    it "does not load working bikes into van if there are fewer than MIN_REQ_WORKING_BIKES in workshop" do
      subject.workshop.clear
      # (Garage::MIN_REQ_WORKING_BIKES - 1).times { subject.workshop << @b3 }
      expect{ subject.load_fixed_into(@van) }.to raise_error "You must prepare at least #{Garage::MIN_REQ_WORKING_BIKES} working bikes for collection"
    end

    it "removes all working bikes from garage workshop (when it contains at least #{Garage::MIN_REQ_WORKING_BIKES} working bikes" do
      # van = Van.new
      # b1, b2 = @b3, @b3
      # b1.report_broken 
      # b2.report_broken
      # subject.workshop << b1 
      # subject.workshop << b2 
      # Garage::MIN_REQ_WORKING_BIKES.times { subject.workshop << @b3 }
      subject.load_fixed_into(@van)
      
      expect(subject.workshop.select { |bike| bike.working?}.count).to eq 0
    end

    it "does not remove any broken bikes from garage workshop" do
      # van = Van.new
      # b1, b2 = @b3, @b3
      # b1.report_broken 
      # b2.report_broken
      # subject.workshop << b1 
      # subject.workshop << b2
      # Garage::MIN_REQ_WORKING_BIKES.times { subject.workshop << @b3 }
      subject.load_fixed_into(@van)
      expect(subject.workshop.include?(@b1 && @b2)).to eq true
    end

    it "places all fixed bikes into the back of the van" do
      # van = Van.new
      # b1, b2 = @b3, @b3
      # b1.report_broken 
      # b2.report_broken
      # subject.workshop << b1 
      # subject.workshop << b2
      # working_bikes = []
      working_bikes = subject.workshop.select { |bike| bike.working? }
      # Garage::MIN_REQ_WORKING_BIKES.times { working_bikes << @b3 } 
      # working_bikes.each { |bike| subject.workshop << bike }
      subject.load_fixed_into(@van)
      expect(@van.back_of).to match_array working_bikes
    end

    it "does not place any broken bikes into the back of the van" do
      # van = Van.new
      # b1, b2 = @b3, @b3
      # b1.report_broken 
      # b2.report_broken
      # subject.workshop << b1 
      # subject.workshop << b2
      # Garage::MIN_REQ_WORKING_BIKES.times { subject.workshop << @b3 }
      subject.load_fixed_into(@van)
      expect(@van.back_of.include?(@b1 || @b2)).to eq false
    end

  end
end