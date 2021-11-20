require 'van'
# how does the van know what a bike is???
describe Van do
  
  context "(transporting broken bikes to garage)" do

    it "allows user to transfer broken bikes to garage" do
      expect(subject).to respond_to(:transfer_broken_to).with(1).argument
    end

    it "no broken bikes remain in the back_of the van" do
      garage = Garage.new
      b1, b2, b3, b4 = Bike.new, Bike.new, Bike.new, Bike.new
      b1.report_broken
      b2.report_broken
      subject.back_of.push(b1, b2, b3, b4)
      subject.transfer_broken_to(garage)
      expect(subject.back_of.include?(b1 || b2)).to eq false
    end

    it "no working bikes are removed from the back_of the van" do
      garage = Garage.new
      b1, b2, b3, b4 = Bike.new, Bike.new, Bike.new, Bike.new
      b1.report_broken
      b2.report_broken
      subject.back_of.push(b1, b2, b3, b4)
      subject.transfer_broken_to(garage)
      expect(subject.back_of.include?(b2 && b3)).to eq true
    end

    it "all broken bikes are transfered to the garage workshop" do
      garage = Garage.new
      b1, b2, b3, b4 = Bike.new, Bike.new, Bike.new, Bike.new
      b1.report_broken
      b2.report_broken
      subject.back_of.push(b1, b2, b3, b4)
      subject.transfer_broken_to(garage)
      expect(garage.workshop.include?(b1 && b2)).to eq true
    end

    it "no working bikes are transfered to the garage workshop" do
      garage = Garage.new
      b1, b2, b3, b4 = Bike.new, Bike.new, Bike.new, Bike.new
      b1.report_broken
      b2.report_broken
      subject.back_of.push(b1, b2, b3, b4)
      subject.transfer_broken_to(garage)
      expect(garage.workshop.include?(b3 || b4)).to eq false
    end

  end

  context "(transporting working bikes to docking station)" do

    it "allows user to transfer working bikes to docking station" do
      expect(subject).to respond_to(:transfer_working_to).with(1).argument
    end

    it "removes all working bikes from station" do 
      station = DockingStation.new
      b1, b2 = Bike.new, Bike.new
      b1.report_broken 
      b2.report_broken
      subject.back_of << b1 
      subject.back_of << b2 
      10.times { subject.back_of << Bike.new }
      subject.transfer_working_to(station)
      expect(subject.back_of.select { |bike| bike.working? }.count).to eq 0
    end

    it "no broken bikes are removed from the back of the van" do 
      station = DockingStation.new
      b1, b2 = Bike.new, Bike.new
      b1.report_broken 
      b2.report_broken
      subject.back_of << b1 
      subject.back_of << b2 
      10.times { subject.back_of << Bike.new }
      subject.transfer_working_to(station)
      expect(subject.back_of.include?(b1 && b2)).to eq true
    end

    it "places all fixed bikes into the docking station rack" do 
      station = DockingStation.new
      b1, b2 = Bike.new, Bike.new
      b1.report_broken 
      b2.report_broken
      subject.back_of << b1 
      subject.back_of << b2 
      working_bikes = []
      10.times { working_bikes << Bike.new }
      working_bikes.each { |bike| subject.back_of << bike }
      subject.transfer_working_to(station)
      expect(station.rack).to match_array working_bikes
    end

    it "does not place any broken bikes into the station rack" do
      station = DockingStation.new
      b1, b2 = Bike.new, Bike.new
      b1.report_broken 
      b2.report_broken
      subject.back_of << b1 
      subject.back_of << b2 
      10.times { subject.back_of << Bike.new }
      subject.transfer_working_to(station)
      expect(station.rack.include?(b1 || b2)).to eq false
    end

    it "raises an error if working bikes exceed available rack space" do
      station = DockingStation.new
      b1, b2 = Bike.new, Bike.new
      b1.report_broken 
      b2.report_broken
      subject.back_of << b1 
      subject.back_of << b2 
      (station.capacity + 1).times { subject.back_of << Bike.new }
      expect{subject.transfer_working_to(station)}.to raise_error 'Rack full, cannot dock bike.'
    end 


  end

end