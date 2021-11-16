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
end