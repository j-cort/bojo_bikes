require 'docking_station'

describe DockingStation do
  it 'allows user to release a bike' do
    expect(subject).to respond_to :release_bike
  end
  it 'returns an instance of the "Bike" class when release_bike is called' do
    subject.rack << Bike.new
    expect(subject.release_bike).to be_instance_of(Bike)
  end
  it 'returns true when asked if its released bike is working' do
    subject.rack << Bike.new
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
    subject.dock(Bike.new)
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
  it 'does not allow user to dock a bike if the rack is not empty' do 
    20.times { subject.dock(Bike.new) }
    expect{ subject.dock(Bike.new) }.to raise_error 'Rack full, cannot dock bike.'
  end
end