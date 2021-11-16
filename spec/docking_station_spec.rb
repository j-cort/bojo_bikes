require 'docking_station'

describe DockingStation do
  it 'allows user to release a bike' do
    expect(subject).to respond_to :release_bike
  end
end