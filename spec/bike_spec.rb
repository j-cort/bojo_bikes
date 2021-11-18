require 'bike'

describe Bike do
  it 'allows user to check if bike is working' do
    expect(subject).to respond_to :working?
  end
  it 'allows user to report a broken bike' do
    expect(Bike.new).to respond_to :report_broken
  end
  it 'broken is true if reported broken' do
    bike = Bike.new
    bike.report_broken
    expect(bike.broken).to eq true
  end
  it 'broken is false if not reported broken' do
    bike = Bike.new
    expect(bike.broken).to eq false
  end
end