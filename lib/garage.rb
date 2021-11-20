class Garage 
  MIN_REQ_WORKING_BIKES = 5
  attr_reader :workshop

  def initialize 
    @workshop = []
  end

  private 

  def enough_fixed_bikes?
    @workshop.select { |bike| !bike.broken }.count >= MIN_REQ_WORKING_BIKES
  end

  public

  def load_fixed_into(van)
    raise 'You must prepare at least 5 working bikes for collection' unless enough_fixed_bikes?
    @workshop.each { |bike| van.back_of << bike if bike.working? } 
    @workshop.select! { |bike| !bike.working? }
  end

end