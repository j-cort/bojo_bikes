require_relative 'bike'

class DockingStation
  DEFAULT_CAPACITY = 20 
  attr_reader :rack
  
  def initialize
    @rack = []
  end

  private 

  def full?
    @rack.count >= DEFAULT_CAPACITY
  end

  def empty?
    @rack.empty?
  end

  public

  def release_bike
    raise 'Sorry, no bikes available to release.' if empty?
    @rack.shift
  end

  def dock(bike)
    raise 'Rack full, cannot dock bike.' if full?
    @rack << bike
  end

  def bike_available?
    @rack.empty? ? false : true
  end
end