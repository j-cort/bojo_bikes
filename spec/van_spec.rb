require 'van'
# how does the van know what a bike is???
describe Van do
  
  context "(transporting broken bikes to garage)" do

    it "no broken bikes remain in the back_of the van" do
      garage = Garage.new
      b1, b2, b3, b4 = Bike.new, Bike.new, Bike.new, Bike.new
      b1.report_broken
      b2.report_broken
      subject.back_of.push(b1, b2, b3, b4)
      subject.transfer_broken_to(garage)
      expect(subject.back_of.include?(b1 || b2)).to eq false
    end

    it "no working bikes are removed from the back_of the van" do
      garage = Garage.new
      b1, b2, b3, b4 = Bike.new, Bike.new, Bike.new, Bike.new
      b1.report_broken
      b2.report_broken
      subject.back_of.push(b1, b2, b3, b4)
      subject.transfer_broken_to(garage)
      expect(subject.back_of.include?(b2 && b3)).to eq true
    end

    it "all broken bikes are transfered to the garage workshop" do
      garage = Garage.new
      b1, b2, b3, b4 = Bike.new, Bike.new, Bike.new, Bike.new
      b1.report_broken
      b2.report_broken
      subject.back_of.push(b1, b2, b3, b4)
      subject.transfer_broken_to(garage)
      expect(garage.workshop.include?(b1 && b2)).to eq true
    end

    it "no working bikes are transfered to the garage workshop" do
      garage = Garage.new
      b1, b2, b3, b4 = Bike.new, Bike.new, Bike.new, Bike.new
      b1.report_broken
      b2.report_broken
      subject.back_of.push(b1, b2, b3, b4)
      subject.transfer_broken_to(garage)
      expect(garage.workshop.include?(b3 || b4)).to eq false
    end

  end

  # context "(collect working bikes from garage)" do 
  #   it "no working bikes remain in garage" do
  #     garage = Garage.new
  #     b1, b2, b3, b4 = Bike.new, Bike.new, Bike.new, Bike.new
  #     b1.report_broken
  #     b2.report_broken
  #     garage.workshop.push(b1, b2, b3, b4)
  #     subject.collect_working_from(garage)
  #     expect(garage.workshop.include?(b3 && b4)).to eq false
  #   end
  # end
end