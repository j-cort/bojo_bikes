require 'docking_station'

describe DockingStation do  
  let(:bike) { double :bike }

  context "(releasing bikes)" do

    it 'allows user to release a bike' do
      expect(subject).to respond_to :release_bike
    end

    it 'returns an instance of the "Bike" class when release_bike is called' do
      bike = Bike.new
      subject.dock(bike) 
      expect(subject.release_bike).to be_instance_of(Bike)
    end

    it 'does not release a bike if rack is empty' do
      expect { subject.release_bike }.to raise_error('Sorry, no bikes available to release.')
    end

    it 'does not release broken bikes' do
      bike = double(:bike, :working? => false, :report_broken => nil)
      bike.report_broken 
      subject.dock(bike) 
      expect{ subject.release_bike }.to raise_error "Bike broken, cannot release bike"
    end

  end
  
  context "(docking bikes)" do

    it 'allows user to dock a bike (instance)' do
      expect(subject).to respond_to(:dock).with(1).argument
    end

    it 'has a rack which stores docked bikes in an array' do
      station = DockingStation.new
      expect(station).to have_attributes(:rack => [])
    end

    it 'stores "bike" in the rack when dock(bike) method is called' do
      expect(subject.dock(bike).include?(bike)).to eq true
    end

    it 'does not allow user to dock a bike if the rack is full' do 
      DockingStation::DEFAULT_CAPACITY.times { subject.dock(bike) } # double zone
      expect{ subject.dock(bike) }.to raise_error 'Rack full, cannot dock bike.'
    end

    it 'allows broken bikes to be docked' do
      bike = double(:bike, :report_broken => nil)
      bike.report_broken 
      subject.dock(bike)
      expect(subject.rack.include?(bike)).to eq true
    end

  end 

  context "(bike state)" do

    it 'returns true when asked if bike is working' do
      bike = double(:bike, :working? => true)
      expect(bike.working?).to eq true
    end

    it 'allows users to check if bikes are available' do
      expect(subject).to respond_to :bike_available? 
    end

    it 'returns true if a bike is available' do
      subject.dock(bike)
      expect(subject.bike_available?).to eq true
    end

    it 'returns false if a bike is not available' do
      expect(subject.bike_available?).to eq false
    end

  end

  context "(bike rack)" do

    it 'allows user to set rack capactiy attribute when new DockingStation is initialized' do
      station = DockingStation.new(30)
      expect(station.capacity).to eq 30
    end
  
    it 'sets rack capacity attribute to DEFAULT_CAPACITY if no value is set by the user' do
      station = DockingStation.new
      expect(station.capacity).to eq 20
    end

  end  

  context "(sending bikes for repair)" do
  
    it "allows user to remove broken bikes" do
      expect(subject).to respond_to(:load_broken_into)
    end

    it "removes broken bikes from rack" do
      bike = Bike.new
      van = Van.new
      bike.report_broken
      subject.dock(bike)
      subject.load_broken_into(van)
      expect(subject.rack.include?(bike)).to eq false
    end

    it "does not remove working bikes from rack" do
      bike = Bike.new
      van = Van.new
      subject.dock(bike)
      subject.load_broken_into(van)
      expect(subject.rack.include?(bike)).to eq true
    end 

    it "places broken bikes in back of van" do
      bike = Bike.new
      van = Van.new
      bike.report_broken
      subject.dock(bike)
      subject.load_broken_into(van)
      expect(van.back_of.include?(bike)).to eq true
    end

    it "does not place working bikes in back of van" do
      bike = Bike.new
      van = Van.new
      subject.dock(bike)
      subject.load_broken_into(van)
      expect(van.back_of.include?(bike)).to eq false
    end

    it "when multiple broken and working bikes are docked, no broken bikes remain in rack" do
      s = DockingStation.new
      b1, b2, b3, b4 = Bike.new, Bike.new, Bike.new, Bike.new
      b1.report_broken
      b2.report_broken
      v = Van.new
      s.dock(b1) 
      s.dock(b2) 
      s.dock(b3)
      s.dock(b4)
      s.load_broken_into(v)
      expect(s.rack.all? { |bike| bike != b1 && bike != b2 }).to eq true
    end

    it "when multiple broken and working bikes are docked, no working bikes are removed from rack" do
      s = DockingStation.new
      b1, b2, b3, b4 = Bike.new, Bike.new, Bike.new, Bike.new
      b1.report_broken
      b2.report_broken
      v = Van.new
      s.dock(b1) 
      s.dock(b2) 
      s.dock(b3)
      s.dock(b4)
      s.load_broken_into(v)
      # is this test correct??
      expect(s.rack.include?(b3 && b4)).to eq true 
    end

    it "when multiple broken and working bikes are docked, all broken bikes are moved to van" do
      s = DockingStation.new
      b1, b2, b3, b4 = Bike.new, Bike.new, Bike.new, Bike.new
      b1.report_broken
      b2.report_broken
      v = Van.new
      s.dock(b1) 
      s.dock(b2) 
      s.dock(b3)
      s.dock(b4)
      s.load_broken_into(v)
      expect(v.back_of.include?(b1 && b2)).to eq true
    end

    it "when multiple broken and working bikes are docked, no working bikes are moved to van" do
      s = DockingStation.new
      b1, b2, b3, b4 = Bike.new, Bike.new, Bike.new, Bike.new
      b1.report_broken
      b2.report_broken
      v = Van.new
      s.dock(b1) 
      s.dock(b2) 
      s.dock(b3)
      s.dock(b4)
      s.load_broken_into(v)
      expect(v.back_of.all? { |bike| bike != b3 && bike != b4 }).to eq true
    end
    
  end
  
end