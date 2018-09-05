## rental.rb

require 'pry'

class Rental < dock

  def initialize(boat, renter)
    @boat = boat
    @renter = renter
  end

  def rent(boat, renter)
    super
  end

end
