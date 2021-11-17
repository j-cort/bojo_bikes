require 'docking_station'

describe DockingStation do
  it 'allows user to release a bike' do
    expect(subject).to respond_to :release_bike
  end
  it 'returns an instance of the "Bike" class when release_bike is called' do
    bike = subject.release_bike
    expect(bike).to be_instance_of(Bike)
  end
  it 'returns true when asked if its released bike is working' do
    bike = subject.release_bike
    expect(bike.working?).to eq true
  end
  it 'allows user to dock a bike (instance)' do
    expect(subject).to respond_to(:dock_bike).with(1).argument
  end
  it 'has a rack to store docked bikes' do
    expect(subject.instance_variable_defined?(:@rack)).to eq true
  end
  it 'rack uses an array to store docked bikes' do
    expect(subject.rack.class).to eq Array
  end
  # later refactor above two tests to use the have_attributes matcher
  # https://relishapp.com/rspec/rspec-expectations/v/3-10/docs/built-in-matchers/have-attributes-matcher
  it 'stores "bike" in the rack when dock_bike(bike) method is called' do
    bike = subject.release_bike
    subject.dock_bike(bike)
    expect(subject.rack.include?(bike)).to eq true
  end
  it 'allows users to check if bikes are available' do
    expect(subject).to respond_to :bike_available? 
  end
  it 'returns true if a bike is available' do
    bike = subject.release_bike
    subject.dock_bike(bike)
    expect(subject.bike_available?).to eq true
  end
  it 'returns false if a bike is not available' do
    expect(subject.bike_available?).to eq false
  end
end