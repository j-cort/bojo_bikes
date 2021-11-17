require_relative 'bike'

class DockingStation
  attr_reader :rack
  def initialize
    @rack = []
  end

  def release_bike
    raise 'Sorry, no bikes available to release.' unless bike_available?
    @rack.shift
  end

  def dock(bike)
    raise 'Rack full, cannot dock bike.' unless @rack.count < 20
    @rack << bike 
  end

  def bike_available?
    @rack.empty? ? false : true
  end
end