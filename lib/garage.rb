class Garage 
  attr_reader :workshop

  def initialize 
    @workshop = []
  end

  private 

  def enough_fixed_bikes?
    @workshop.select { |bike| !bike.broken }.count >= 5
  end

  public

  def load_fixed_into(van)
    raise 'You must prepare at least 5 working bikes for collection' unless enough_fixed_bikes?
    
  end

end