require_relative 'garage'

class Van
  attr_reader :back_of

  def initialize
    @back_of = []
    @successfully_docked = []
  end

  def transfer_broken_to(garage)
    @back_of.each { |bike| garage.workshop << bike if !bike.working? }
    @back_of.select! { |bike| bike.working? }
  end

  def transfer_working_to(station)
    @back_of.each { |bike| station.dock(bike) and @successfully_docked << bike if bike.working? }
    @back_of.select! { |bike| !@successfully_docked.include?(bike)}
  end
  
end



