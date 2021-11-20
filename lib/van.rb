require_relative 'garage'

class Van
  attr_reader :back_of

  def initialize
    @back_of = []
  end

  def transfer_broken_to(garage)
    @back_of.each { |bike| garage.workshop << bike if !bike.working? }
    @back_of.select! { |bike| bike.working? }
  end

  # def collect_working_from(garage)
  #   garage:workshop = []
  # end
  
end



