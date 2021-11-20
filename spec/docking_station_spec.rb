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
      DockingStation::DEFAULT_CAPACITY.times { subject.dock(bike) } 
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
    before(:each) do
      @b1, @b2, @b3, @b4 = Bike.new, Bike.new, Bike.new, Bike.new
      @b1.report_broken
      @b2.report_broken
      @van = Van.new
      subject.dock(@b1) 
      subject.dock(@b2) 
      subject.dock(@b3)
      subject.dock(@b4)
      subject.load_broken_into(@van)
    end

    it "allows user to remove broken bikes" do
      expect(subject).to respond_to(:load_broken_into).with(1).argument
    end

    it "removes all broken bikes from rack" do
      expect(subject.rack.include?(@b1 || @b2)).to eq false
    end

    it "does not remove any working bikes from rack" do
      expect(subject.rack.include?(@b3 && @b4)).to eq true
    end 

    it "places all broken bikes in back of van" do
      expect(@van.back_of.include?(@b1 && @b2)).to eq true
    end

    it "does not place any working bikes in back of van" do
      expect(@van.back_of.include?(@b3 || @b4)).to eq false
    end
    
  end
  
end