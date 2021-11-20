require 'bike'

describe Bike do

  it 'allows user to check if bike is working' do
    expect(subject).to respond_to :working?
  end

  context "(broken bikes)" do
  
    it 'allows user to report a broken bike' do
      expect(Bike.new).to respond_to :report_broken
    end

    it 'sets broken to true if reported broken' do
      bike = Bike.new
      bike.report_broken
      expect(bike.broken).to eq true
    end

    it 'broken is false if working bike is not reported broken' do
      bike = Bike.new
      expect(bike.broken).to eq false
    end

  end

  context "(fixed bikes)" do

    it 'allows user to report a bike as fixed' do
      expect(Bike.new).to respond_to :report_fixed
    end

    it 'sets broken to false if reported fixed' do
      bike = Bike.new
      bike.report_broken
      bike.report_fixed
      expect(bike.broken).to eq false
    end

    it 'broken is true if broken bike is not reported fixed' do
      bike = Bike.new
      bike.report_broken
      expect(bike.broken).to eq true
    end
    
  end
  
end