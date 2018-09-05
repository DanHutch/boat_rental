## rental_test.rb

require 'minitest/autorun'
require 'minitest/pride'
require './lib/boat'
require './lib/dock'
require 'pry'
require './lib/rental'
require "./lib/renter"

class RentalTest < Minitest::Test

  def test_it_exists
    kayak_1 = Boat.new(:kayak, 20)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    rental = Rental.new(kayak_1, patrick)
    assert_instance_of(Rental, rental)
  end


end
