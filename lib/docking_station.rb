require_relative 'bike'

class DockingStation
  attr_reader :rack
  def initialize
    @rack = []
  end

  def release_bike
    Bike.new
  end

  def dock_bike(bike)
    @rack << bike
  end

  def bike_available?
    @rack.empty? ? false : true
  end
end