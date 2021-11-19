require_relative 'bike'

class DockingStation
  DEFAULT_CAPACITY = 20 
  attr_reader :rack
  attr_reader :capacity

  def initialize(capacity = DEFAULT_CAPACITY)
    @rack = []
    @capacity = capacity
  end

  private 

  def full?
    @rack.count >= DEFAULT_CAPACITY
  end

  def empty?
    @rack.empty?
  end

  def broken?
    !@rack[0].working?
  end

  public

  def release_bike
    raise 'Sorry, no bikes available to release.' if empty?
    raise 'Bike broken, cannot release bike' if broken?
    @rack[0]
  end

  def dock(bike)
    raise 'Rack full, cannot dock bike.' if full?
    @rack << bike
  end

  def bike_available?
    @rack.empty? ? false : true
  end
  
end