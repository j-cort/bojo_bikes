require 'docking_station'

describe DockingStation do
  # let(:bike) { double :bike }
  
  it 'allows user to release a bike' do
    expect(subject).to respond_to :release_bike
  end
  it 'returns an instance of the "Bike" class when release_bike is called' do
    #double zone - XX
    allow(bike).to receive(:working?).and_return(true)
    subject.dock(bike) 
    expect(subject.release_bike).to be_instance_of(Class)
  end
  it 'returns true when asked if its released bike is working' do
    #double zone - fixed
    bike = double(:bike, :working? => true)
    subject.dock(bike) 
    bike = subject.release_bike
    expect(bike.working?).to eq true
  end
  it 'allows user to dock a bike (instance)' do
    expect(subject).to respond_to(:dock).with(1).argument
  end
  it 'has a rack to store docked bikes' do
    expect(subject.instance_variable_defined?(:@rack)).to eq true
  end
  it 'rack uses an array to store docked bikes' do
    expect(subject.rack.class).to eq Array
  end
  # later refactor above two tests to use the have_attributes matcher
  # https://relishapp.com/rspec/rspec-expectations/v/3-10/docs/built-in-matchers/have-attributes-matcher
  it 'stores "bike" in the rack when dock(bike) method is called' do
    bike = Bike.new
    expect(subject.dock(bike).include?(bike)).to eq true
  end
  it 'allows users to check if bikes are available' do
    expect(subject).to respond_to :bike_available? 
  end
  it 'returns true if a bike is available' do
    subject.dock(double(:bike)) # double zone
    expect(subject.bike_available?).to eq true
  end
  it 'returns false if a bike is not available' do
    expect(subject.bike_available?).to eq false
  end
  it 'does not release a bike if rack is empty' do
    if !subject.bike_available?
      expect { subject.release_bike }.to raise_error('Sorry, no bikes available to release.')
    end
  end
  it 'does not allow user to dock a bike if the rack is full' do 
    DockingStation::DEFAULT_CAPACITY.times { subject.dock double(:bike) } # double zone
    expect{ subject.dock double(:bike) }.to raise_error 'Rack full, cannot dock bike.'
  end
  it 'allows user to set capactiy attribute when new DockingStation is initialized' do
    station = DockingStation.new(30)
    expect(station.capacity).to eq 30
  end
  it 'sets capacity attribute to DEFAULT_CAPACITY if no value is set by the user' do
    station = DockingStation.new
    expect(station.capacity).to eq 20
  end
  it 'does not release broken bikes' do
    # double zone - fixed
    # allow(bike).to receive(:report_broken)
    # allow(bike). to receive(:working?).and_return(false)
    bike = double(:bike, :working? => false, :report_broken => nil)
    bike.report_broken 
    subject.dock(bike) 
    expect{ subject.release_bike }.to raise_error "Bike broken, cannot release bike"
  end
  it 'allows broken bikes to be docked' do
    # double zone - fixed
    bike = double(:bike, :report_broken => nil)
    bike.report_broken 
    subject.dock(bike)
    expect(subject.rack.include?(bike)).to eq true
  end
end