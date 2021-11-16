require 'bike'

describe Bike do
  it 'allows user to check if bike is working' do
    expect(subject).to respond_to :working?
  end
end